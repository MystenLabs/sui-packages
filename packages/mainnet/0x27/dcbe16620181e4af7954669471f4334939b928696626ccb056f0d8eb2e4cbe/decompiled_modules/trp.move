module 0x27dcbe16620181e4af7954669471f4334939b928696626ccb056f0d8eb2e4cbe::trp {
    struct TRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRP>(arg0, 6, b"TRP", b"TRUMPIT", b"Hoping to Win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Roman_empire_2_346129e6aa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

