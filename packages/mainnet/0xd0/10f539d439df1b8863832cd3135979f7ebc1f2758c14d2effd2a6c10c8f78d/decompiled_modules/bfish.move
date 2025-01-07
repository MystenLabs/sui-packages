module 0xd010f539d439df1b8863832cd3135979f7ebc1f2758c14d2effd2a6c10c8f78d::bfish {
    struct BFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFISH>(arg0, 9, b"BFISH", b"BullFish", b"BULISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS03rORrfbIBpAaThE6ehKf4u594TrUQPXpQQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BFISH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

