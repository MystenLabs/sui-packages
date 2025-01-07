module 0xc9e85c43e5b58b5dbad40fcf26ea2d476ddb5c61163220951901bdf73b2bf41f::gangs {
    struct GANGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANGS>(arg0, 6, b"GANGS", b"SUI GANGS", b"SUI Network Gangsters Meeting Place", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xca3875cf962872351f2eed60254bc50fbeb6ba396cca62292199d5f2c95ae9f3_gangs_gangs_78696e6d0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GANGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

