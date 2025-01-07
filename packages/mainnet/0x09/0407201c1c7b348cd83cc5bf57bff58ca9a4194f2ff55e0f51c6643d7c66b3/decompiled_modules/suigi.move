module 0x90407201c1c7b348cd83cc5bf57bff58ca9a4194f2ff55e0f51c6643d7c66b3::suigi {
    struct SUIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGI>(arg0, 9, b"SUIGI", b"Suigi", b"The heart of this world was Luigi, a humble yet courageous explorer known as Suigi to his companions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fphoto_2024_10_09_02_39_35_55e6b10bcb.jpg&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

