module 0x9264ac276f2e5944105a2dba5020eb8fa206bb1b41f0d79abac67a259e04ffcf::ksui {
    struct KSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUI>(arg0, 6, b"Ksui", b"Ksui Movtyan", b"My daughter meme! I love you daughter <3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733347785755.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

