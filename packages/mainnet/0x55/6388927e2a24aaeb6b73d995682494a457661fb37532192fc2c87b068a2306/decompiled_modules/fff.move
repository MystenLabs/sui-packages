module 0x556388927e2a24aaeb6b73d995682494a457661fb37532192fc2c87b068a2306::fff {
    struct FFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFF>(arg0, 9, b"FFF", b"fff", b"ff fe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzqBvzdVf-9AKTWLtxFIOKkqPY_K9pOViKMA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FFF>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFF>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FFF>>(v2);
    }

    // decompiled from Move bytecode v6
}

