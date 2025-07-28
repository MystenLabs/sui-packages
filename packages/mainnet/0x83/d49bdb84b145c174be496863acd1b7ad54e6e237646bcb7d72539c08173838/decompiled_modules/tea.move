module 0x83d49bdb84b145c174be496863acd1b7ad54e6e237646bcb7d72539c08173838::tea {
    struct TEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEA>(arg0, 6, b"Tea", b"TeaCoin", b"cu-$TEA memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreier4ovf2ayyh7vruvzg2g6v52fvycdemlxmqlnx24zippuvl5wn44")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

