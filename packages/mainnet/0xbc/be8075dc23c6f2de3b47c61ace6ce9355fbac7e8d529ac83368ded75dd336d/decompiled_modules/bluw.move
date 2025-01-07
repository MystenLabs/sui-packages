module 0xbcbe8075dc23c6f2de3b47c61ace6ce9355fbac7e8d529ac83368ded75dd336d::bluw {
    struct BLUW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUW>(arg0, 6, b"BLUW", b"BluwOnSui", b"Cutest Vibes, Diamond Hands, and Lambo Dreams. Join the BLUWiverse! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blub_0e2dc763e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUW>>(v1);
    }

    // decompiled from Move bytecode v6
}

