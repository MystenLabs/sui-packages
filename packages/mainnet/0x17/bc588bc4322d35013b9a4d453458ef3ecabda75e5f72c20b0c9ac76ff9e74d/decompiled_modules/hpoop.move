module 0x17bc588bc4322d35013b9a4d453458ef3ecabda75e5f72c20b0c9ac76ff9e74d::hpoop {
    struct HPOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPOOP>(arg0, 6, b"HPOOP", b"HAPPY POOP", b"A HAPPY AND YOUNG POOP SMILE AND ANSIOU TO THE LAUNCH IN THE SUI. :P", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731468034192.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HPOOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPOOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

