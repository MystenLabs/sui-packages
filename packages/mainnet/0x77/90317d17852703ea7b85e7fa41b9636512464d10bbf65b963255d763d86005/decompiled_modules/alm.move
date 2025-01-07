module 0x7790317d17852703ea7b85e7fa41b9636512464d10bbf65b963255d763d86005::alm {
    struct ALM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALM>(arg0, 9, b"ALM", b"Almanac ", b"Gaming token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78b6111e-eb07-42d4-8435-d2cc2ca330fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALM>>(v1);
    }

    // decompiled from Move bytecode v6
}

