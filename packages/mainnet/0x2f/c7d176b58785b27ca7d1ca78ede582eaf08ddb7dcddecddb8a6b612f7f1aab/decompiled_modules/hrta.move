module 0x2fc7d176b58785b27ca7d1ca78ede582eaf08ddb7dcddecddb8a6b612f7f1aab::hrta {
    struct HRTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRTA>(arg0, 9, b"HRTA", b"the heart", x"4120686561727466656c7420616e6420696e73706972696e672063727970746f63757272656e6379207468617420656d626f64696573206c6f76652c20636f6d70617373696f6e20616e6420756e6974790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9ba766c-4140-4bae-b859-9ee07e3e1411.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

