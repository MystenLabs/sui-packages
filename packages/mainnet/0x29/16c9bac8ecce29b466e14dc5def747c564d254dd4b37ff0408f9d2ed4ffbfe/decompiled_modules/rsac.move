module 0x2916c9bac8ecce29b466e14dc5def747c564d254dd4b37ff0408f9d2ed4ffbfe::rsac {
    struct RSAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSAC>(arg0, 9, b"RSAC", b"CARS", x"416363656c657261746520746865206578636974656d656e7420776974682043415253204d656d65636f696e2c20616e20616476616e636564206469676974616c2063757272656e6379207468617420656d626f64696573207468652064796e616d696320776f726c64206f6620636172730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d57a072-89db-414c-837a-a33c9129b68b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

