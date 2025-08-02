module 0x8c07e65f8582b14932489280edf270b3ba9b5ac08667e6a7649eabdfade25c35::COLA {
    struct COLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLA>(arg0, 6, b"Coke", b"cola", b"Please give me Coke.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/e6883ca0-e140-47eb-9afe-4817f64ff505")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLA>>(v0, @0xf1309375411a68dbefec91ca13490e61caf3eb1eb24fa0dd3cf38884b04a5d14);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

