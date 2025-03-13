module 0x78b9b3915c6cf3b082dd0ef90e86e7d15a15ae08612f6266c1095768ee2e46b2::jez {
    struct JEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEZ>(arg0, 9, b"JEZ", b"Jez", b"this coin is not from any company or investor, do not buy it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8856246-68f6-4b19-ada6-808cdf8290c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

