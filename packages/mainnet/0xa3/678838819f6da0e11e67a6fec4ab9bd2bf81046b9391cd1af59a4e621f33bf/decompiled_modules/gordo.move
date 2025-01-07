module 0xa3678838819f6da0e11e67a6fec4ab9bd2bf81046b9391cd1af59a4e621f33bf::gordo {
    struct GORDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORDO>(arg0, 6, b"Gordo", b"Gordo monkey sui", x"476f72646f2c206120726865737573206d6163617175652c207761732073656e7420696e746f2073706163652062792074686520556e6974656420537461746573206f6e0a446563656d6265722031332c20313935382c2061626f61726420746865204a75706974657220414d2d313320726f636b65742e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_3_a61c88e474.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

