module 0x9fd168f4dd280cc364834eb6d686c01888d8391abd96c5eacf93f568a06b2d63::hulk {
    struct HULK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HULK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HULK>(arg0, 9, b"HULK", b"Snug Hulk", b"Mascot Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/623/254/large/salvatore-saraceno-screenshot000.jpg?1728054258")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HULK>(&mut v2, 500000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HULK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HULK>>(v1);
    }

    // decompiled from Move bytecode v6
}

