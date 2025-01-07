module 0x52dd4ce8f95bd693d11306f7e31734d5f6b5be70f3cfdde1fe29369f851e8ffb::suirio {
    struct SUIRIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRIO>(arg0, 6, b"SUIRIO", b"Sui mario", b"$SUIRIO iconic catch phrase - Pump Pump Pump Pump. He is celebrating his memecoin launch with a FIST to the jeets !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053743_aeebe1d6d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

