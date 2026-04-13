module 0xadfe1faa16b9022a4500569770e5c5ef3de3d461ddfb8996247ab9efb01c136a::verifier {
    struct Endpoint<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        relay_pubkey: vector<u8>,
        last_nonce_in: u64,
        next_nonce_out: u64,
        vault: 0x2::balance::Balance<T0>,
    }

    struct Locked has copy, drop {
        endpoint_id: address,
        nonce: u64,
        amount: u64,
        recipient_hash: vector<u8>,
        sender: address,
    }

    struct Released has copy, drop {
        endpoint_id: address,
        nonce: u64,
        amount: u64,
        recipient: address,
    }

    struct KeyRotated has copy, drop {
        endpoint_id: address,
        new_pubkey: vector<u8>,
    }

    public entry fun create<T0>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 205);
        let v0 = Endpoint<T0>{
            id             : 0x2::object::new(arg1),
            owner          : 0x2::tx_context::sender(arg1),
            relay_pubkey   : arg0,
            last_nonce_in  : 0,
            next_nonce_out : 0,
            vault          : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Endpoint<T0>>(v0);
    }

    public fun last_nonce_in<T0>(arg0: &Endpoint<T0>) : u64 {
        arg0.last_nonce_in
    }

    public entry fun lock<T0>(arg0: &mut Endpoint<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 100000000, 204);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 205);
        let v1 = arg0.next_nonce_out;
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        arg0.next_nonce_out = v1 + 1;
        let v2 = Locked{
            endpoint_id    : 0x2::object::id_address<Endpoint<T0>>(arg0),
            nonce          : v1,
            amount         : v0,
            recipient_hash : arg2,
            sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Locked>(v2);
    }

    public fun next_nonce_out<T0>(arg0: &Endpoint<T0>) : u64 {
        arg0.next_nonce_out
    }

    public fun owner<T0>(arg0: &Endpoint<T0>) : address {
        arg0.owner
    }

    fun push_u128_be(arg0: &mut vector<u8>, arg1: u128) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 16) {
            0x1::vector::push_back<u8>(&mut v0, ((arg1 % 256) as u8));
            arg1 = arg1 / 256;
            v1 = v1 + 1;
        };
        let v2 = 16;
        while (v2 > 0) {
            let v3 = v2 - 1;
            v2 = v3;
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v3));
        };
    }

    fun push_u64_be(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg1 % 256) as u8));
            arg1 = arg1 / 256;
            v1 = v1 + 1;
        };
        let v2 = 8;
        while (v2 > 0) {
            let v3 = v2 - 1;
            v2 = v3;
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v3));
        };
    }

    public fun relay_pubkey<T0>(arg0: &Endpoint<T0>) : vector<u8> {
        arg0.relay_pubkey
    }

    public entry fun release<T0>(arg0: &mut Endpoint<T0>, arg1: u64, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > arg0.last_nonce_in, 202);
        assert!(0x1::vector::length<u8>(&arg4) == 64, 206);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        push_u64_be(v1, arg1);
        let v2 = &mut v0;
        push_u128_be(v2, (arg2 as u128));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        let v3 = 0x1::hash::sha2_256(v0);
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.relay_pubkey, &v3), 201);
        arg0.last_nonce_in = arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg2), arg5), arg3);
        let v4 = Released{
            endpoint_id : 0x2::object::id_address<Endpoint<T0>>(arg0),
            nonce       : arg1,
            amount      : arg2,
            recipient   : arg3,
        };
        0x2::event::emit<Released>(v4);
    }

    public entry fun rotate_key<T0>(arg0: &mut Endpoint<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 203);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 205);
        arg0.relay_pubkey = arg1;
        let v0 = KeyRotated{
            endpoint_id : 0x2::object::id_address<Endpoint<T0>>(arg0),
            new_pubkey  : arg1,
        };
        0x2::event::emit<KeyRotated>(v0);
    }

    public fun vault_value<T0>(arg0: &Endpoint<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    // decompiled from Move bytecode v7
}

