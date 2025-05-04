module 0xd712671e76714d130a0b314fcfd519b5ac09bc931d2a0a55aa9f2f16f0c8b3c::ariv {
    struct ARIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARIV>(arg0, 2, b"Ariv", b"Ariv", b"Ariv Membership", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arivmarketplace.sirv.com/Restaurant%20Images/arivM.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARIV>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

