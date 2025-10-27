module 0xff46f0de2e6fb51d9016de1f72f8fdd8544c00eee0662ad2a022bc8281b6f938::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"Sui", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

