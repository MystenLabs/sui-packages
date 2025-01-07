module 0x4905591625b2d618e5a3f0386c7194ef72b5931fddd450b07a059287bfa94946::tid {
    struct TID has drop {
        dummy_field: bool,
    }

    fun init(arg0: TID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TID>(arg0, 9, b"TID", b"tired", x"746861742069732065786875617374656420636f696e206861686120f09fa497", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a04f372b-ee0d-4096-9a02-94ec28c832d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TID>>(v1);
    }

    // decompiled from Move bytecode v6
}

