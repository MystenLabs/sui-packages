module 0x871ee6954eef8e7db570acc1fc9291ebfbb54f6d46cb8819b44274b4e29af645::mcsui {
    struct MCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCSUI>(arg0, 6, b"McSui", b"MCSUI", b"From king of crypto, to king of hamburgers. When you have lost everything, there is always a fry to share!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cto_dc8af71e18.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

