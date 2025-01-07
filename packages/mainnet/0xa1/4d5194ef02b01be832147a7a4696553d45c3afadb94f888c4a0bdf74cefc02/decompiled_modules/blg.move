module 0xa14d5194ef02b01be832147a7a4696553d45c3afadb94f888c4a0bdf74cefc02::blg {
    struct BLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLG>(arg0, 6, b"BLG", b"BELUGA", b"BELUGA COMMUNITY IS HERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/belugamove_e9da21ac81.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

