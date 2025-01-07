module 0x5ff73cae5b01499f4e6289f1a89b5c9c7c6c120a9250d06697180e2c817dde17::seacow {
    struct SEACOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEACOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEACOW>(arg0, 6, b"SEACOW", b"Sui Seacow", b"SUI Seacow is a digital collectible project built on the SUI Chain, showcasing the majestic species of stellar seacows. creating an immersive experience, combining blockchain technology with stunning visuals and engaging gameplay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001977_82f7509635.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEACOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEACOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

