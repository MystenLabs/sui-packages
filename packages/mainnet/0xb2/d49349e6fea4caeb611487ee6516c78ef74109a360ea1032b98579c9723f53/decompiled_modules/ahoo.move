module 0xb2d49349e6fea4caeb611487ee6516c78ef74109a360ea1032b98579c9723f53::ahoo {
    struct AHOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHOO>(arg0, 9, b"AHOO", b"AHOO", b"Ahoo is newgen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUyf53KxgEVE0vYCTtx_Fy5tTNIYt9PWyxFQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AHOO>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AHOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

