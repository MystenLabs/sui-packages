module 0xa00771a889738b837ca6b35b06e3263404946aac908d021b7ff6118bfbd1e6d8::alphacat {
    struct ALPHACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHACAT>(arg0, 6, b"ALPHACAT", b"ALPHACAT on Sui", b"ALPHACAT - The Alpha of all meme coins, roaring its way through the SUI blockchain! With mad gains in its sights and a mission to leave the jeets behind, ALPHACAT is here to give, share, and exude pure alpha.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ALPHACAT_Icon_500x500_bda5a3ff4e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPHACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

