module 0x5bcfe7ef5e47b7c4dd71835aed83ae0335d49cbeaa69c994951b746c54220f7c::suipanda {
    struct SUIPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPANDA>(arg0, 6, b"SUIPANDA", b"SUI PANDA", b"Illustrator 12 contact DM or p3530834@gmail.com FANBOXhttps://panda0035.fanbox.cc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_1195743934_612x612_0cc80a397c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

