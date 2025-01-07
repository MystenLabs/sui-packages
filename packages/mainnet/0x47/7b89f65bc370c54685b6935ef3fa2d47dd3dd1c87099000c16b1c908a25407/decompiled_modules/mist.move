module 0x477b89f65bc370c54685b6935ef3fa2d47dd3dd1c87099000c16b1c908a25407::mist {
    struct MIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIST>(arg0, 6, b"MIST", b"Mist", b"$MIST is a mystery. People are buying $MIST directly from the hop.fun platform, but few have the coding knowledge to do so. We've now democratized it, and you can also buy $MIST.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coin_default_0a3f161586.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

