module 0x7dd0135f7d784d0f0c4299bb95ddd2a5b766e92c0d1a8c2285ad4d8e9f31d3e2::early_cb_nft {
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

    public entry fun amount(arg0: &EarlyCBNFT) : u64 {
        arg0.amount
    }

    public entry fun destroy(arg0: EarlyCBNFT) {
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

    public entry fun mint_and_send(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = EarlyCBNFT{
            id     : 0x2::object::new(arg1),
            name   : 0x1::string::utf8(b"Early CB NFT"),
            tiers  : 0x1::string::utf8(b"Gold"),
            amount : 40000,
            url    : 0x1::string::utf8(b"url"),
        };
        0x2::transfer::public_transfer<EarlyCBNFT>(v0, arg0);
    }

    public fun name(arg0: &EarlyCBNFT) : 0x1::string::String {
        arg0.name
    }

    public fun set_url(arg0: &AdminCap, arg1: &mut EarlyCBNFT, arg2: 0x1::string::String) {
        arg1.url = arg2;
    }

    public entry fun tiers(arg0: &EarlyCBNFT) : 0x1::string::String {
        arg0.tiers
    }

    public fun url(arg0: &EarlyCBNFT) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

