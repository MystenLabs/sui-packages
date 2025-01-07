module 0x2c0b0031c23cea24ed02e96f1840c9c41b809cb85c4cd387447c72ecff982c30::catcute {
    struct CATCUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCUTE>(arg0, 9, b"CATCUTE", b"Cat", b"My catcute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9e69d59-2a59-4deb-a294-5ce7ddd0c331.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATCUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

