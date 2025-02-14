module 0x4cd6bc709db0aa8be3daafae18f769517af9e4f9ef06e002176392799d830cd9::chamber {
    struct CHAMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMBER>(arg0, 9, b"CHAMBER", b"Harry Potter and the Chamber of Secrets", b"Harry Potter and the Chamber of Secrets is a movie about Harry Potter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/harrypotter/images/c/c5/Harry_Potter_and_the_Chamber_of_Secrets_UK_Poster.jpg/revision/latest?cb=20150209181936")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHAMBER>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMBER>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

