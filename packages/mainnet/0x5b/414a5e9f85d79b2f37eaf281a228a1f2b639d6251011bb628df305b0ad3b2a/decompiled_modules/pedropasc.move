module 0x5b414a5e9f85d79b2f37eaf281a228a1f2b639d6251011bb628df305b0ad3b2a::pedropasc {
    struct PEDROPASC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEDROPASC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEDROPASC>(arg0, 9, b"PEDROPASC", b"Pedro Pascal", b"Born: April 2, 1975, Santiago, Chile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/PEDROPASC.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEDROPASC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEDROPASC>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEDROPASC>>(v1);
    }

    // decompiled from Move bytecode v6
}

