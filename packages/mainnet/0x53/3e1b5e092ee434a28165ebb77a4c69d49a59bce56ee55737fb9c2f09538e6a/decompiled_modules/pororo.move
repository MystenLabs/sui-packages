module 0x533e1b5e092ee434a28165ebb77a4c69d49a59bce56ee55737fb9c2f09538e6a::pororo {
    struct PORORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORORO>(arg0, 6, b"PORORO", b"Pororo", b"Hi there, I'm Pororo! I'm a little blue penguin with a big heart, and I'm here to take you on a journey through my world of fun and adventures. Alongside my diverse group of friends, we explore the wonders of Porong Porong Forest, facing challenges and learning valuable lessons along the way. So, come join me and my pals as we embark on exciting escapades, laughter, and friendship in the magical world of Porong Porong!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_19_40_49_583cd857fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

