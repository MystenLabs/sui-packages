module 0xd95e9dad85435ebb54594c2a54d65f0d990b6db1272149f2f3d11dcb60edd62e::nb {
    struct NB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NB>(arg0, 9, b"NB", b"Noo", b"for blastroyale community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8e3c718-5760-4cd5-b9ca-f0161749db1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NB>>(v1);
    }

    // decompiled from Move bytecode v6
}

