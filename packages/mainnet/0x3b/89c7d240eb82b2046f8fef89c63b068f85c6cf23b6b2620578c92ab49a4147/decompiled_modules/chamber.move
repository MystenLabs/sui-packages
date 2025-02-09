module 0x3b89c7d240eb82b2046f8fef89c63b068f85c6cf23b6b2620578c92ab49a4147::chamber {
    struct CHAMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMBER>(arg0, 9, b"CHAMBER", b"Harry Potter and the Chamber of Secrets", b"Harry Potter and the Chamber of Secrets is a movie about Harry Potter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHAMBER>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMBER>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

