module 0xd2cef3f3d5daf43fc9f15d1ff9d71db327581754b315b660391d1d285fb79de4::chizosui {
    struct CHIZOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIZOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIZOSUI>(arg0, 6, b"CHIZOSUI", b"CHIZO ON SUI", x"776520636f6f636b20342064612068756e67657279206f6e65730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vh_I9f_5_Y_400x400_05f3620ff2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIZOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIZOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

