module 0x5e87b823d40bf0f7c0d165ada2afafb7a9b01314b0e88e4518d0889fd9792d4c::blup {
    struct BLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUP>(arg0, 6, b"BLUP", b"BLUE PURR", b"A blue-blooded cat who will take his place at the top. BLUP is soft and fluffy but also a true hunter. Dogs, frogs, and fish are all prey for BLUP. There will be only one king left and it will be a BLUP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoround2_cdeca8b879.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

