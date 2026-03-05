module 0x46778c50c33a783d94d5339ff74be2657aef2e53f7f4265fa129e27808e22765::pass_sbt {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PassState has key {
        id: 0x2::object::UID,
        base_uri: 0x1::string::String,
        signee_pubkey: vector<u8>,
        used: 0x2::table::Table<vector<u8>, bool>,
        mint_fee_mist: u64,
        treasury: address,
        next_mint_index: u64,
    }

    struct PassSBT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        mint_index: u64,
        minted_at_ms: u64,
    }

    struct Ticket has copy, drop {
        state_id: address,
        minter: address,
        token: vector<u8>,
    }

    public fun url(arg0: &PassSBT) : &0x2::url::Url {
        &arg0.url
    }

    fun address_hex_0x(arg0: address) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::bcs::to_bytes<address>(&arg0))));
        v0
    }

    fun build_url_string(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : 0x1::string::String {
        0x1::string::append(&mut arg0, arg1);
        0x1::string::append(&mut arg0, arg2);
        arg0
    }

    public fun description(arg0: &PassSBT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = PassState{
            id              : 0x2::object::new(arg0),
            base_uri        : 0x1::string::utf8(b""),
            signee_pubkey   : 0x1::vector::empty<u8>(),
            used            : 0x2::table::new<vector<u8>, bool>(arg0),
            mint_fee_mist   : 0,
            treasury        : v0,
            next_mint_index : 0,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PassState>(v1);
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    entry fun mint(arg0: &mut PassState, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg0.mint_fee_mist, 3);
        let v1 = ticket_message(arg0, v0, &arg1);
        verify_and_consume(arg0, v1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury);
        let v2 = arg0.next_mint_index;
        arg0.next_mint_index = v2 + 1;
        let v3 = PassSBT{
            id           : 0x2::object::new(arg5),
            name         : 0x1::string::utf8(b"Early Urchian Pass"),
            description  : 0x1::string::utf8(b"On-chain access pass that confirms your eligibility for Urchin Wave campaign and unlocks the dashboard."),
            url          : 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(build_url_string(arg0.base_uri, address_hex_0x(v0), 0x1::string::utf8(b".png")))),
            mint_index   : v2,
            minted_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::transfer::transfer<PassSBT>(v3, v0);
    }

    public fun mint_index(arg0: &PassSBT) : u64 {
        arg0.mint_index
    }

    public fun minted_at_ms(arg0: &PassSBT) : u64 {
        arg0.minted_at_ms
    }

    public fun name(arg0: &PassSBT) : &0x1::string::String {
        &arg0.name
    }

    entry fun set_base_uri(arg0: &AdminCap, arg1: &mut PassState, arg2: vector<u8>) {
        arg1.base_uri = 0x1::string::utf8(arg2);
    }

    entry fun set_mint_fee_mist(arg0: &AdminCap, arg1: &mut PassState, arg2: u64) {
        arg1.mint_fee_mist = arg2;
    }

    entry fun set_signee_pubkey(arg0: &AdminCap, arg1: &mut PassState, arg2: vector<u8>) {
        arg1.signee_pubkey = arg2;
    }

    entry fun set_treasury(arg0: &AdminCap, arg1: &mut PassState, arg2: address) {
        arg1.treasury = arg2;
    }

    fun ticket_message(arg0: &PassState, arg1: address, arg2: &vector<u8>) : vector<u8> {
        let v0 = Ticket{
            state_id : 0x2::object::id_address<PassState>(arg0),
            minter   : arg1,
            token    : *arg2,
        };
        0x2::bcs::to_bytes<Ticket>(&v0)
    }

    fun verify_and_consume(arg0: &mut PassState, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0.signee_pubkey) == 32, 2);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.signee_pubkey, &arg1), 0);
        let v0 = 0x2::hash::blake2b256(&arg1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used, v0), 1);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used, v0, true);
    }

    // decompiled from Move bytecode v6
}

