module 0xd2b0e7fc47f49bb020ec243b397000666d4019dc2d5a5a4aacc50ef24d835a4a::blood {
    struct BLOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOD>(arg0, 6, b"BLOOD", b"Blood", b"Don't let your wallet flatline with $BLOODless tokens. Infuse it with real $BLOOD and watch your profits skyrocket!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734789103899.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

