module 0xde1f3c64b5a277134ef9b3173cccda38cbbbe8d6e1260238a042ebaedad56058::tort {
    struct TORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORT>(arg0, 9, b"TORT", b"KUIV", b"Conditer333", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4975c11d-ce00-4983-b1c5-d73f01fa9fc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TORT>>(v1);
    }

    // decompiled from Move bytecode v6
}

