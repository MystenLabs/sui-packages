module 0xd1148eac32af207fd8c69d24d8d3f8f244ba6035cbccf71149e3f664b78e2b14::lara {
    struct LARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARA>(arg0, 6, b"LARA", b"FARTSEUS MAXIMUS", b"A Women Who Inspired The Fart Movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LARA_05c4993c35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

