module 0x67d418a166f4f33132cc3d37ada75b60075749f7b90773572b2558c401a893f9::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 9, b"DAWG", b"Corndawg", b"Dog that loves corndogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.reddit.com/r/funny/comments/awr7d5/corn_dog/")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAWG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

