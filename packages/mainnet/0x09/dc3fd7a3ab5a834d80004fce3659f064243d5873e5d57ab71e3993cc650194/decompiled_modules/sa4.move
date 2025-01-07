module 0x9dc3fd7a3ab5a834d80004fce3659f064243d5873e5d57ab71e3993cc650194::sa4 {
    struct SA4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA4>(arg0, 9, b"SA4", b"songanh4", b"SA4 token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a61cf634-ae00-4cb7-a803-11d6b9213f22.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SA4>>(v1);
    }

    // decompiled from Move bytecode v6
}

