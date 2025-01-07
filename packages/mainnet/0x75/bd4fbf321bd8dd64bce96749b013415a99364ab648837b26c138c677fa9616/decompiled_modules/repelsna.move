module 0x75bd4fbf321bd8dd64bce96749b013415a99364ab648837b26c138c677fa9616::repelsna {
    struct REPELSNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: REPELSNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REPELSNA>(arg0, 9, b"REPELSNA", b"Jacinta Ch", b"Eguvfc stfdsg syguf hugrdhhf yfdfhgx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d074886-b950-4adb-88e4-d004d3bea170.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REPELSNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REPELSNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

