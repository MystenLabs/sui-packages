module 0x9942f19fa59eaae7198b4f5395dfe3fa7fcd643260e86f9f5a4372852fbf241d::mope {
    struct MOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOPE>(arg0, 6, b"MOPE", b"MOPE SUI", b"Mope is Hope. Immortal and Everlasting. Join us, and learn what it means to be a mope.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_Zitjnm_B_400x400_e9c0607957.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

