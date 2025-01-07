module 0x7def6edaa08f2971b2c5509928483febad6119a87e008dbfbebc928d3ff992c4::mb {
    struct MB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MB>(arg0, 9, b"MB", b"MONKE", b"MonkeyBuissnesCrypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb57f1b1-0d88-4554-82ad-c393f97e2ba1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MB>>(v1);
    }

    // decompiled from Move bytecode v6
}

