module 0x9932d77214a12b82d310f7d8275227caabb091787e5acc2d8fbfc3a1e0d001a::substance {
    struct SUBSTANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBSTANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBSTANCE>(arg0, 9, b"SUBSTANCE", b"The Substance", b"A fading celebrity takes a black-market drug: a cell-replicating substance that temporarily creates a younger, better version of herself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/SUBSTANCE.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUBSTANCE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBSTANCE>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBSTANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

