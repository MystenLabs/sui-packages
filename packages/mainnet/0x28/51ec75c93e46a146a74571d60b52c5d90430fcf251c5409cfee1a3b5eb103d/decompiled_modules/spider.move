module 0x2851ec75c93e46a146a74571d60b52c5d90430fcf251c5409cfee1a3b5eb103d::spider {
    struct SPIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIDER>(arg0, 9, b"SPIDER", b"Spider Sui", b"Spider is comming on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9853a633a535305cb2d5d0e64fbfc2a9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPIDER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIDER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

