module 0x42d1c9822cdee33e3423edb98a86e97b939ddabf53f6226c7db2898a040277ae::qp {
    struct QP has drop {
        dummy_field: bool,
    }

    fun init(arg0: QP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QP>(arg0, 9, b"QP", b"Aalal", b"Qoqo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef8590e6-832f-4e27-83f5-fb1348fde13d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QP>>(v1);
    }

    // decompiled from Move bytecode v6
}

