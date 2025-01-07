module 0xa5d43431038cfa1d52ba6f5893dff3a20355c51bf1e11a969d953fffab37b8a::hcm {
    struct HCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCM>(arg0, 9, b"HCM", x"48e1bb93204368c3ad204d696e", x"48e1bb93204368c3ad206d496e682043697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1214c2c2-63c5-4cab-84e7-b34109157fe4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

