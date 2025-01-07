module 0xc7a8c34294813f3a26d8a8627048f8191db270f5c2351643cf70c547d69fdd1c::bulls {
    struct BULLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLS>(arg0, 6, b"BULLS", b"Battle Bulls", b"BATTLE BULLS is an exciting play-to-earn battle game! Play, win, and get rewards!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jih_OCKNO_400x400_4b08301fd4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

