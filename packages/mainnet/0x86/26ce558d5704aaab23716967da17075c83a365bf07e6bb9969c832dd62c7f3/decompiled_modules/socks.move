module 0x8626ce558d5704aaab23716967da17075c83a365bf07e6bb9969c832dd62c7f3::socks {
    struct SOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKS>(arg0, 6, b"SOCKS", b"SUISocks", b"SuiSocks: The world's most valuable digital socks! No one will have cold feet anymore because SuiSocks keeps the entire crypto community warm. SOCKS holders don't just get virtual happiness; they also enjoy the comfort of knowing their feet (and wallets) are protected. These arent just ordinary socksowning SOCKS is a symbol of belonging to the most stylish and secure crypto family. With SuiSocks, step up and feel the warmth of true digital ownership!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_Socks_Logo_b3ef309abe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

