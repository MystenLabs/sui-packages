module 0x959ab4feaf255286938ae0cb871c32811a6da472ab66119fe37e177310ca5231::gps {
    struct GPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPS>(arg0, 6, b"GPS", b"Tracked Turtle", b"Live GPS feed of a real sea turtle in the ocean. Bot in development! Dex paid, will create tele upon bonding. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e1acdb8f_989c_415e_92e8_9fdb85782088_fad70ccd13.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

