module 0x4d42b234ae08f8045001b9ba6ad160439ca69f2b468746088e7f392d6242aa82::tmn {
    struct TMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMN>(arg0, 9, b"TMN", b"TREENOOB", x"4272616e64696e672077697468206e6174757265207468656d650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/349853c5-331a-41ee-aa2c-25c582bf5be3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

