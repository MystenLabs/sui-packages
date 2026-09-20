module 0x79521e547135b98f10ad523dbe2acaef17cdaac36bdf35f479b82d77c4417d2::suitard {
    struct SUITARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITARD>(arg0, 9, b"SUITARD", b"SUITARD CLUB", b"A gift for the SUI community. Suitards love SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/1374c5b9c2cb9fd7cfebe1d58db56ec069c4d37ac869259e784f75a6ff6f466a")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITARD>>(0x2::coin::mint<SUITARD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITARD>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

