module 0x3ed1f208d90eecd6487dfc87ee8f3122699f162a3ff7c21604969a9a47fd1163::vnpump {
    struct VNPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNPUMP>(arg0, 9, b"VNPUMP", b"VN Pump", b"VN pump is token for Vietnam Waver. Get rich with us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98425c7c-4e42-44c5-ac1d-bc1a0fc15481.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VNPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

