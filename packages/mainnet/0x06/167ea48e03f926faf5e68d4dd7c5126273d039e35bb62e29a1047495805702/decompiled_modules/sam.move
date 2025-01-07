module 0x6167ea48e03f926faf5e68d4dd7c5126273d039e35bb62e29a1047495805702::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAM>(arg0, 9, b"SAM", b"Samuel", b"My cat Samuel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/631aedfa-6cbd-4e4a-b2f6-0242703d054c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

