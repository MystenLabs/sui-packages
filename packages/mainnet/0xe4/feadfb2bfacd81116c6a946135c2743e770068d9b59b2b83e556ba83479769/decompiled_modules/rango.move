module 0xe4feadfb2bfacd81116c6a946135c2743e770068d9b59b2b83e556ba83479769::rango {
    struct RANGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RANGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RANGO>(arg0, 6, b"RANGO", b"SUI RANGO", x"52616e676f20697320646976696e6720696e746f20746865205355492065636f73797374656d21200a0a54686520446573657274204b696e67206973206d616b696e6720776176657320696e2074686520576174657220436861696e202824535549292e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_12_11_48_08a_PM_b79b6960ce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RANGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RANGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

