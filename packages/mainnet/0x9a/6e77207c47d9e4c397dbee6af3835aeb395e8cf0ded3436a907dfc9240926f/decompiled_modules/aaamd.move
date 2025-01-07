module 0x9a6e77207c47d9e4c397dbee6af3835aeb395e8cf0ded3436a907dfc9240926f::aaamd {
    struct AAAMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAMD>(arg0, 6, b"AAAMD", b"AAA Moo Deng", b"AAA Moo Deng - Memecoin of Moo Deng on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaa_hippo_logo_e9afc9b165.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

