module 0x1f2cc28aab2daae3394f128d060564636f61a1bf1a07ad11602b5dc15479651e::pundutoken {
    struct PUNDUTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNDUTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNDUTOKEN>(arg0, 6, b"PUNDUTOKEN", b"PUNDUSUI", b"$PUNDU the first meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CTMV_1d_ZU_400x400_23ed5cde36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNDUTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNDUTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

