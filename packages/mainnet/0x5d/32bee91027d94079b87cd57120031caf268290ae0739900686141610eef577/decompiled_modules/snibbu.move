module 0x5d32bee91027d94079b87cd57120031caf268290ae0739900686141610eef577::snibbu {
    struct SNIBBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIBBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIBBU>(arg0, 6, b"SNIBBU", b"Snibbu on Sui", b"The king of sideways markets, hates sudden ups and downs, yellow, Craziest Crab on sui! Lets ride the waves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732014146637.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNIBBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIBBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

