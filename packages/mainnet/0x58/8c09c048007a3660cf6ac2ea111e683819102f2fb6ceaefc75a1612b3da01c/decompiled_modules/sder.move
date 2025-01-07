module 0x588c09c048007a3660cf6ac2ea111e683819102f2fb6ceaefc75a1612b3da01c::sder {
    struct SDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDER>(arg0, 6, b"Sder", b"Suinder", b"The first dating app on the $sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fsuider_91f9f89f63.png&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDER>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDER>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDER>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

