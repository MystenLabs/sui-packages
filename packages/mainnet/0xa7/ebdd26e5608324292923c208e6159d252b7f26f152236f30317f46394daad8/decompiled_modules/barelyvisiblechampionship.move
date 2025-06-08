module 0xa7ebdd26e5608324292923c208e6159d252b7f26f152236f30317f46394daad8::barelyvisiblechampionship {
    struct BARELYVISIBLECHAMPIONSHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARELYVISIBLECHAMPIONSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARELYVISIBLECHAMPIONSHIP>(arg0, 6, b"BARELYVISIBLECHAMPIONSHIP", b"BVC", b"Mega viral trend in japan right now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bvc_1ae2c30483.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARELYVISIBLECHAMPIONSHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARELYVISIBLECHAMPIONSHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

