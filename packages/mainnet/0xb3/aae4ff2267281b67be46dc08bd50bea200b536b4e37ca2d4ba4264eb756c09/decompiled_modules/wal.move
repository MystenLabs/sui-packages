module 0xb3aae4ff2267281b67be46dc08bd50bea200b536b4e37ca2d4ba4264eb756c09::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 9, b"WAL", b"walbirth", b"walrus birthday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e5fe066-e832-46f8-ab0f-f59c49cc82c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

