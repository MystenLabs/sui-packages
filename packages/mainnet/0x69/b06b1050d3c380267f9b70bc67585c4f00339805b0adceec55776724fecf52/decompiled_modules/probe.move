module 0x69b06b1050d3c380267f9b70bc67585c4f00339805b0adceec55776724fecf52::probe {
    struct Singleton has key {
        id: 0x2::object::UID,
        channel: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel,
        admin: address,
    }

    struct Blob has store, key {
        id: 0x2::object::UID,
        junk: vector<u8>,
    }

    struct Inflated has copy, drop {
        blob: address,
        bytes: u64,
        source_chain: 0x1::ascii::String,
    }

    public fun register_transaction(arg0: &mut 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery, arg1: &Singleton) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, x"02");
        0x1::vector::push_back<vector<u8>>(v1, concat(x"00", 0x2::address::to_bytes(0x2::object::id_address<Singleton>(arg1))));
        let v2 = 0x1::type_name::with_defining_ids<Singleton>();
        let v3 = 0x1::type_name::address_string(&v2);
        let v4 = 0x1::vector::empty<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>();
        0x1::vector::push_back<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>(&mut v4, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_move_call(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_function(0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v3))), 0x1::ascii::string(b"probe"), 0x1::ascii::string(b"execute")), v0, 0x1::vector::empty<0x1::ascii::String>()));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::register_transaction(arg0, &arg1.channel, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_transaction(true, v4));
    }

    fun concat(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        arg0
    }

    public fun execute(arg0: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg1: &mut Singleton, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _, v3) = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::consume_approved_message(&arg1.channel, arg0);
        let v4 = v3;
        let v5 = parse_size(&v4);
        let v6 = Blob{
            id   : 0x2::object::new(arg2),
            junk : fill(v5),
        };
        0x2::transfer::public_transfer<Blob>(v6, arg1.admin);
        let v7 = Inflated{
            blob         : 0x2::object::id_address<Blob>(&v6),
            bytes        : v5,
            source_chain : v0,
        };
        0x2::event::emit<Inflated>(v7);
    }

    fun fill(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, ((v1 % 251) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Singleton{
            id      : 0x2::object::new(arg0),
            channel : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Singleton>(v0);
    }

    fun parse_size(arg0: &vector<u8>) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0;
        let v2 = if (v0 >= 8) {
            v0 - 8
        } else {
            0
        };
        let v3 = v2;
        while (v3 < v0) {
            let v4 = v1 << 8;
            v1 = v4 | (*0x1::vector::borrow<u8>(arg0, v3) as u64);
            v3 = v3 + 1;
        };
        if (v1 > 200000) {
            200000
        } else {
            v1
        }
    }

    public fun reclaim(arg0: Blob) {
        let Blob {
            id   : v0,
            junk : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v7
}

