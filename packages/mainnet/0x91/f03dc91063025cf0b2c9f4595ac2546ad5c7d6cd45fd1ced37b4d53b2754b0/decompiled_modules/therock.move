module 0x91f03dc91063025cf0b2c9f4595ac2546ad5c7d6cd45fd1ced37b4d53b2754b0::therock {
    struct THEROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEROCK>(arg0, 6, b"THEROCK", b"The Rock(Dwayne)", b"The Rock(Dwayne Douglas Johnson)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732213180085.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEROCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEROCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

