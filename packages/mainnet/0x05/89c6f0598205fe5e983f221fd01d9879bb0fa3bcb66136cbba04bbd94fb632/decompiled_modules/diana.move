module 0x589c6f0598205fe5e983f221fd01d9879bb0fa3bcb66136cbba04bbd94fb632::diana {
    struct DIANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIANA>(arg0, 9, b"DIANA", b"Ankudinova", b"Official Diana's token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3b4fcc4-3c62-48d7-8b91-0e6d8fcd605d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

