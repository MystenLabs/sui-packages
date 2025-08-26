module 0x4800258cc92b9663715f22dae1f6861a26af18584654997528eb0f0592b77288::Coin_Coin {
    struct COIN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_COIN>(arg0, 9, b"COIN", b"Coin Coin", b"here is a coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3KD7Z9Z3CH9M1DQF35Q8QMX.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

