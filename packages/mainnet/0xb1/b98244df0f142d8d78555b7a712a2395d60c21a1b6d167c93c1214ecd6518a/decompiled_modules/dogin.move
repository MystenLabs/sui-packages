module 0xb1b98244df0f142d8d78555b7a712a2395d60c21a1b6d167c93c1214ecd6518a::dogin {
    struct DOGIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGIN>(arg0, 9, b"DOGIN", b"Dogin Hood", b"The first Robin Hood Sui meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1836283905911197698/bLC4Z4ge_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

