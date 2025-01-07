module 0x6dba9aaff720df63fe228d735488ede0e630071f59bd869be2e022346d69840c::early_cb_nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct EarlyCBNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        tiers: 0x1::string::String,
        amount: u64,
        url: 0x1::string::String,
    }

    struct EarlyCBNFTMinted has copy, drop {
        bond_id: vector<0x2::object::ID>,
        minted_by: address,
        minted_to: vector<address>,
    }

    public fun destroy(arg0: EarlyCBNFT) {
        let EarlyCBNFT {
            id     : v0,
            name   : _,
            tiers  : _,
            amount : _,
            url    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_and_send(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = EarlyCBNFT{
            id     : 0x2::object::new(arg6),
            name   : arg1,
            tiers  : arg2,
            amount : arg4,
            url    : arg3,
        };
        0x2::transfer::public_transfer<EarlyCBNFT>(v0, arg5);
    }

    public fun name(arg0: &EarlyCBNFT) : 0x1::string::String {
        arg0.name
    }

    public fun set_url(arg0: &AdminCap, arg1: &mut EarlyCBNFT, arg2: 0x1::string::String) {
        arg1.url = arg2;
    }

    public fun tiers(arg0: &EarlyCBNFT) : 0x1::string::String {
        arg0.tiers
    }

    public fun url(arg0: &EarlyCBNFT) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

