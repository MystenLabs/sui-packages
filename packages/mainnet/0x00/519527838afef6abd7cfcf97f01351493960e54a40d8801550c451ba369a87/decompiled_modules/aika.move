module 0x519527838afef6abd7cfcf97f01351493960e54a40d8801550c451ba369a87::aika {
    struct AIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIKA>(arg0, 6, b"AIKA", b"aika", b"aika", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIKA>>(0x2::coin::mint<AIKA>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIKA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

