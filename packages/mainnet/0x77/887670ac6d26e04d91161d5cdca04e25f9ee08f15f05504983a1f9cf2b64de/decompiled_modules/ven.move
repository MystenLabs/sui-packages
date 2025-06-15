module 0x77887670ac6d26e04d91161d5cdca04e25f9ee08f15f05504983a1f9cf2b64de::ven {
    struct VEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEN>(arg0, 6, b"VEN", b"Vendetta", b"A fully on-chain, multiplayer strategy game on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifon6tli2pxz5ruj7mzwmgiawfpxkrzuupr5ejzzovglwddbsfoay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

