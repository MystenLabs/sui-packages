module 0xe10abb5483f63d10fef0fae76c49f4b554bb7e8e7f866d77d2783cceb85ad73c::sfret {
    struct SFRET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFRET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFRET>(arg0, 6, b"SFRET", b"Fret The Cat From Sui", b"SFRET is a token that embodies creativity and inspiration from a unique digital world, as depicted in our visuals. With relentless energy, SFRET symbolizes an innovative movement to reignite community spirit and empowerment through blockchain technology. Join SFRET, a token that sparks imagination and uniqueness in every transaction!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000085263_dacd259d6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFRET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFRET>>(v1);
    }

    // decompiled from Move bytecode v6
}

