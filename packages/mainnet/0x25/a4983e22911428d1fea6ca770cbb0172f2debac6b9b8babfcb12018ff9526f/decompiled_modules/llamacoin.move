module 0x25a4983e22911428d1fea6ca770cbb0172f2debac6b9b8babfcb12018ff9526f::llamacoin {
    struct LLAMACOIN has drop {
        dummy_field: bool,
    }

    struct TokenConfig has key {
        id: 0x2::object::UID,
        owner: address,
        total_supply: u64,
        treasury_cap: 0x2::coin::TreasuryCap<LLAMACOIN>,
    }

    public fun get_total_supply(arg0: &TokenConfig) : u64 {
        arg0.total_supply
    }

    fun init(arg0: LLAMACOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LLAMACOIN>(arg0, 6, b"LLAMA", b"AI Llama", b"AI Llama ($LLAMA) is a simple token on the Sui Network. No custom tokenomics.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://salmon-bright-baboon-859.mypinata.cloud/ipfs/bafkreibtt334a723p6qkawq4uj5smsqckjpkq55eyibjhqqqqug3et53qa")), arg1);
        let v3 = v1;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLAMACOIN>>(v2);
        let v4 = TokenConfig{
            id           : 0x2::object::new(arg1),
            owner        : v0,
            total_supply : 100000000000000000,
            treasury_cap : v3,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<LLAMACOIN>>(0x2::coin::mint<LLAMACOIN>(&mut v3, 100000000000000000, arg1), v0);
        0x2::transfer::share_object<TokenConfig>(v4);
    }

    // decompiled from Move bytecode v6
}

