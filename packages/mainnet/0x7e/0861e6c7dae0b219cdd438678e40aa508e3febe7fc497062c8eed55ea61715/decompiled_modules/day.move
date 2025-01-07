module 0x7e0861e6c7dae0b219cdd438678e40aa508e3febe7fc497062c8eed55ea61715::day {
    struct DAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAY>(arg0, 9, b"DAY", b"banh", b"good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ed52d2c-d5c1-418c-8f74-c389840f51a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

