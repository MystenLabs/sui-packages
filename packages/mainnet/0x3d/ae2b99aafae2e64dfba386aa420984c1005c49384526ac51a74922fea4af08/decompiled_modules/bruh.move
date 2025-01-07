module 0x3dae2b99aafae2e64dfba386aa420984c1005c49384526ac51a74922fea4af08::bruh {
    struct BRUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUH>(arg0, 6, b"Bruh", b"SUI Bruh", b"Bruh... what?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000045369_071dfe45e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

