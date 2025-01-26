module 0xf3bf0ad597e7243abaa711cceb4b14f41ae890800fc43878fe1ba00950c73be9::jobless {
    struct JOBLESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOBLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOBLESS>(arg0, 6, b"JOBLESS", b"LIVE: I Lost My Job", x"4d79206e616d65206973204a6f65792049e280996d204c495645206f6e204947206c696e6b20616464656420746f20776562736974652e2049206c6f7374206d79206a6f6220492068617665206e6f20666f6f64206f72206865617420696e206d792061706172746d656e74206275742049e280996d2073746179696e6720706f7369746976652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737857874402.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOBLESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOBLESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

