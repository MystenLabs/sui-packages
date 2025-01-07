module 0xd121a8de8462d7a7e61caf175155f5049247a8aed514f82ba83e0dff39dc7b57::wmln {
    struct WMLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMLN>(arg0, 6, b"Wmln", b"Watermelon", b"Plant your seeds and let's go to the moon to build a colony. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001173439_f0b87465e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

