module 0xae256d04f765677f3fc90ca65ee2788c4efcc0c68448be8620165b4e0af80a25::etu {
    struct ETU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETU>(arg0, 6, b"ETU", b"Sui Etu", b"Hi, Im ETU. A parody meme of the infamous phrase Expect The Unexpected", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002861_5791f55fbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETU>>(v1);
    }

    // decompiled from Move bytecode v6
}

