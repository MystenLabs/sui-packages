module 0xc97d2a7ee744a4b1e0f78682907a80f3e38ae29bf2b255a6f98b939c84de2256::dolphy {
    struct DOLPHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHY>(arg0, 6, b"Dolphy", b"Dolphy SUI", b"Dolphins are dangerous. They hide behind those cute smiles, but they are known to be the second most intelligent animals, and believe it or not, they are already among us. This is your chance to get on the right side of the market, with the new currency, which will sweep away everything you've ever known about the crypto world. Buy $DOLPHY or succumb to the new world order", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gif_500_4f2bafc09b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

