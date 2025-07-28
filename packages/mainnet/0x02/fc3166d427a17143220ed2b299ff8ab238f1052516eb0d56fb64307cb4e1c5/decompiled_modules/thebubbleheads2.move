module 0x2fc3166d427a17143220ed2b299ff8ab238f1052516eb0d56fb64307cb4e1c5::thebubbleheads2 {
    struct THEBUBBLEHEADS2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEBUBBLEHEADS2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEBUBBLEHEADS2>(arg0, 9, b"Bubble", b"The Bubbleheads", b"Website: https://jup.ag/studio/3G1yVFfKzZxsvTnAnJMQzZBtyTpfWUTY6G7685nRjups | Twitter: https://x.com/i/communities/1949444656288387479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static-create.jup.ag/images/3G1yVFfKzZxsvTnAnJMQzZBtyTpfWUTY6G7685nRjups")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THEBUBBLEHEADS2>(&mut v2, 1000000000000000000, @0xc5c7eae937011cafd988cbff68ffb66c081dbcffea6de371228f06c2a4e88e22, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEBUBBLEHEADS2>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEBUBBLEHEADS2>>(v1);
    }

    // decompiled from Move bytecode v6
}

