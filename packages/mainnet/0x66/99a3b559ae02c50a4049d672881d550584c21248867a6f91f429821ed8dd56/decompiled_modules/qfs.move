module 0x6699a3b559ae02c50a4049d672881d550584c21248867a6f91f429821ed8dd56::qfs {
    struct QFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: QFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QFS>(arg0, 9, b"QFS", b"Qfs17", b"Quantum Financial System", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e3753ab-c41c-4300-ad27-3ab5134de035.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

