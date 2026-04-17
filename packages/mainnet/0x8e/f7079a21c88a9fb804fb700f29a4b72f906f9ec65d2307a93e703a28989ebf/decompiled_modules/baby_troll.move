module 0x8ef7079a21c88a9fb804fb700f29a4b72f906f9ec65d2307a93e703a28989ebf::baby_troll {
    struct BABY_TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY_TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY_TROLL>(arg0, 9, b"Baby Troll", b"Baby Troll", b"the baby troll on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776452256612-17321dd6634a915ada71ca16eb1b1e02.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BABY_TROLL>>(0x2::coin::mint<BABY_TROLL>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY_TROLL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY_TROLL>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

