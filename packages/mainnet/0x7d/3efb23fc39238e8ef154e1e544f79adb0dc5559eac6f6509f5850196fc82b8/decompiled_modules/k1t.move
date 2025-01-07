module 0x7d3efb23fc39238e8ef154e1e544f79adb0dc5559eac6f6509f5850196fc82b8::k1t {
    struct K1T has drop {
        dummy_field: bool,
    }

    fun init(arg0: K1T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K1T>(arg0, 9, b"K1T", b"SUBWey", b"Fun and good way to BHOLD greater heights. Together is the key", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db2c4ea0-4ba7-4b19-bb8e-b6898355711d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K1T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K1T>>(v1);
    }

    // decompiled from Move bytecode v6
}

