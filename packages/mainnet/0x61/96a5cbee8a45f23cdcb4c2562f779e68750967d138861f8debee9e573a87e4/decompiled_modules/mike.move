module 0x6196a5cbee8a45f23cdcb4c2562f779e68750967d138861f8debee9e573a87e4::mike {
    struct MIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKE>(arg0, 6, b"MIKE", b"MIKE TYSON", b"Mike Tyson to win the fight against Jake Paul at the age of 57 !! Believe this as you believe to send $MIKE to Radium Now! no more cats and dogs it's time we unleash the Tiger!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mike_d90bf4d124.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

