module 0xaa420e6acae57f15b9ca164233050d1452a8eb2cbe2f4c02f75f9c545a09f0cc::hawktuah {
    struct HAWKTUAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWKTUAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWKTUAH>(arg0, 6, b"HAWKTUAH", b"Hawk Tuah", x"4841574b5455414820616e642073706974206f6e2074686174207468696e67210a53706974206f6e206974210a53706974206f6e20697421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_f8722e370a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWKTUAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWKTUAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

