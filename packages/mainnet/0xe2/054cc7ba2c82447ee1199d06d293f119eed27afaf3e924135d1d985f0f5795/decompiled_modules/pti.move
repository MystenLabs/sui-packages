module 0xe2054cc7ba2c82447ee1199d06d293f119eed27afaf3e924135d1d985f0f5795::pti {
    struct PTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTI>(arg0, 9, b"PTI", b"Pakistan ", b"Nice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cfde1b91-ccee-4c00-87f1-c2ac8a79f01d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

