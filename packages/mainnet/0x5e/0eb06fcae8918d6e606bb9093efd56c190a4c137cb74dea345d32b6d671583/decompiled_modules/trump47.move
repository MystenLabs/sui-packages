module 0x5e0eb06fcae8918d6e606bb9093efd56c190a4c137cb74dea345d32b6d671583::trump47 {
    struct TRUMP47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP47>(arg0, 6, b"TRUMP47", b"47$", x"446f6e616c64204a2e205472756d702031203437746820507265736964656e74206f662074686520556e69746564537461746573206f6620416d65726963610a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000357_0aa848ea2b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP47>>(v1);
    }

    // decompiled from Move bytecode v6
}

