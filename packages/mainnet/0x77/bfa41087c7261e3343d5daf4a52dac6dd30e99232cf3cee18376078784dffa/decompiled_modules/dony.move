module 0x77bfa41087c7261e3343d5daf4a52dac6dd30e99232cf3cee18376078784dffa::dony {
    struct DONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONY>(arg0, 6, b"DONY", b"Trump Dynasty", b"$DONY is coming to solana to make crypto great again, he is tired of jeets and indian devs tarnishing his reputation for pennies, $DONY WILL show the way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_034013_601_41beed8352.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

