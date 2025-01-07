module 0x666da6cdb236572d09bb01bfad9f1d0c27a60db7cbd3edc5a00237c7a657b721::rrr {
    struct RRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRR>(arg0, 9, b"RRR", b"EE", b"QSDAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa42e6e6-66bd-4d66-bab9-cb1d0226cb3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

