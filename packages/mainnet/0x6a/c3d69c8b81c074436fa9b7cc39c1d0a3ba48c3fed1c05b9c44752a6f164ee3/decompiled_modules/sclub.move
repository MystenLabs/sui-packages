module 0x6ac3d69c8b81c074436fa9b7cc39c1d0a3ba48c3fed1c05b9c44752a6f164ee3::sclub {
    struct SCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCLUB>(arg0, 6, b"SCLUB", b"Boys club  on  Sui", b"Where memes meet friendship in perfect harmony. Step into the world of Pepe, Andy, Brett, Bird Dog and Landwolf!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/boy_308f4f7ea8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

