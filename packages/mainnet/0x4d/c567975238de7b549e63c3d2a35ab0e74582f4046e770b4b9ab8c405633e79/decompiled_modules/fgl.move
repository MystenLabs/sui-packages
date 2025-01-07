module 0x4dc567975238de7b549e63c3d2a35ab0e74582f4046e770b4b9ab8c405633e79::fgl {
    struct FGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGL>(arg0, 9, b"FGL", b"FIEND GHUL", b"FIEND GHUL IS ACARECTER DESINED BY ME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed84e8eb-b363-4a7d-9349-783152b65db1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

