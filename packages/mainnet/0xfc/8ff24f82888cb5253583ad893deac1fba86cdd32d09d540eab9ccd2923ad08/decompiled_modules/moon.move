module 0xfc8ff24f82888cb5253583ad893deac1fba86cdd32d09d540eab9ccd2923ad08::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 9, b"MOON", b"Sui Moon", b"Sui Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://t3.gstatic.com/licensed-image?q=tbn:ANd9GcT1g1V8Nalm9FkR2atv7annUXbPvk5g-mWffaNxT_ItIFogl-6mC_lHNifw5Tw9-yiS"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOON>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

