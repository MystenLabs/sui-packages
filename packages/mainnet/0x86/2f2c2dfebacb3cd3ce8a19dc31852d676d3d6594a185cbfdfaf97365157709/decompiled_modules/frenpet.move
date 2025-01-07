module 0x862f2c2dfebacb3cd3ce8a19dc31852d676d3d6594a185cbfdfaf97365157709::frenpet {
    struct FRENPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENPET>(arg0, 6, b"FrenPet", b"Sui Fren Pet", b"own and grow with your onchain fren meme token sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/frens_807d93bfe3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENPET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRENPET>>(v1);
    }

    // decompiled from Move bytecode v6
}

