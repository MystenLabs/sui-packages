module 0xf65975183e2cfc94857edd67c9b7731b637c93e6129bdf804cdaaddb1ad13a88::suie {
    struct SUIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIE>(arg0, 6, b"SUIE", b"Sui-Sooie", b"When you're charging through the crypto market like a beast, but still HODLing Suie with style!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suie_818f8e66d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

