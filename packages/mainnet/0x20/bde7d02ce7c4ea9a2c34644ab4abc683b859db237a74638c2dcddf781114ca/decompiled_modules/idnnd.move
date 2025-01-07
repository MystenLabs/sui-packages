module 0x20bde7d02ce7c4ea9a2c34644ab4abc683b859db237a74638c2dcddf781114ca::idnnd {
    struct IDNND has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDNND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDNND>(arg0, 9, b"IDNND", b"jsnene", b"bxjejn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7194f3ea-2ccd-4215-b041-17f9d9c0a69a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDNND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDNND>>(v1);
    }

    // decompiled from Move bytecode v6
}

