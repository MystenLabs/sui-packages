module 0x80c6afe25b808a087f6c9052e99549490ac01ac5a74fe958e9ec29ae2b4a91a1::mememe {
    struct MEMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEME>(arg0, 6, b"MEMEME", b"MEME", b"Buy now or regret. Buy now or regret. Buy now or regret. Buy now or regret. Buy now or regret.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_28_at_14_40_59_c70bae3738.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

