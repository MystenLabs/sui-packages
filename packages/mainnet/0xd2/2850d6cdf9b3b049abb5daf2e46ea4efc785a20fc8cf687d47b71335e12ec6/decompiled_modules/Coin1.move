module 0xd22850d6cdf9b3b049abb5daf2e46ea4efc785a20fc8cf687d47b71335e12ec6::Coin1 {
    struct COIN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN1>(arg0, 9, b"C1", b"Coin1", b"Coin 1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3DMQPT1V0MX8Q4Y6RPXNTGV.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

