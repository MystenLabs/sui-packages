module 0xc6bd3b26a1eb51662a9dd9c5bbc1e3f54b0b19adad64d83ad4d2e4e471cab0bf::gaia {
    struct GAIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAIA>(arg0, 6, b"GAIA", b"Terra & Gaia", x"546572726120616e642047616961206172652074686520706572736f6e696669636174696f6e73206f6620456172746820616e642074686520616e6365737472616c206d6f7468657273206f6620616c6c206c6966652e2e2e0a4e6f772c20746865206d6f7468657273206f6620616c6c204d454d4553206f6e207468652053554920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GLOBO_2cd6e174fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

