module 0x3260fd29d6430994b30b010045a5b35aa038e572152260c73452f01bc07531a4::bremp {
    struct BREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREMP>(arg0, 6, b"BREMP", b"BRETT TRUMP", x"244252454d50204973204272657474205472756d702e20546865203437746820507265736964656e742066726f6d20555320235472756d7020f09f87baf09f87b820", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731435678313.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BREMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

