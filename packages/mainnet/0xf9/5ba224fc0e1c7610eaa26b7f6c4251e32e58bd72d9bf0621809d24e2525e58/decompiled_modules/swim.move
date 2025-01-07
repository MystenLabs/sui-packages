module 0xf95ba224fc0e1c7610eaa26b7f6c4251e32e58bd72d9bf0621809d24e2525e58::swim {
    struct SWIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIM>(arg0, 6, b"Swim", b"Swimdog", x"446f67207374617973207377696d6d696e67200a0a536f6369616c732063726561746564206174206b6f74732c20646f672073686f756c6420646f2077656c6c2074686572652c206865207573656420746f2073776d6d696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4743_70c7af18d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

