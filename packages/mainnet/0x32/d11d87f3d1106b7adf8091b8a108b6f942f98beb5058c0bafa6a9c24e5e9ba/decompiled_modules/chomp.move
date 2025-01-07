module 0x32d11d87f3d1106b7adf8091b8a108b6f942f98beb5058c0bafa6a9c24e5e9ba::chomp {
    struct CHOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMP>(arg0, 6, b"CHOMP", b"CHOMPSUI", b"Dopest Art & Memes in the Space $CHOMP is the fiercest little fuzzball on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xebff2db643cf955247339c8c6bcd8406308ca437_3ce9746e8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

