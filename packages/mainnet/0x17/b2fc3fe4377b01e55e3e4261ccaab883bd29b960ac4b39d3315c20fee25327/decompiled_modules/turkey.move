module 0x17b2fc3fe4377b01e55e3e4261ccaab883bd29b960ac4b39d3315c20fee25327::turkey {
    struct TURKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURKEY>(arg0, 6, b"TURKEY", b"Turkey on Sui", b"lets switch it up and eat milfs like Yung Gravy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifm74aeuitnrbx7zksawd45recwsl7fjd3vbv532tsjrhkl6pve7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TURKEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

