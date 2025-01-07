module 0xbed48ac9d045fa5dae0b34c0331ed4198fa5ff0c11802cd914a477b6e0b4119c::pubu {
    struct PUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUBU>(arg0, 6, b"PUBU", b"PUFF BUNNY", b"America Puff Bunny - a Trump Supporter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961785065.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

