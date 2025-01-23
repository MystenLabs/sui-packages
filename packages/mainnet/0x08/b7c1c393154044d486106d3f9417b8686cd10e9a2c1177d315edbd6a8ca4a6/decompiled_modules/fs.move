module 0x8b7c1c393154044d486106d3f9417b8686cd10e9a2c1177d315edbd6a8ca4a6::fs {
    struct FS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FS>(arg0, 9, b"FS", b"FROGSUI", b"Frogsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/311c486f-9582-42e7-b939-04eacece04fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FS>>(v1);
    }

    // decompiled from Move bytecode v6
}

