module 0xcb33e2632d915780f5f2ccf37b7845073ed3eb73039e447e661c45832e69dff0::fofar {
    struct FOFAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOFAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOFAR>(arg0, 6, b"FOFAR", b"Fofar the Pig", b"A legendary character inspired by Matt Furie's Boy's Club comic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snort_9c22fc2601.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOFAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOFAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

