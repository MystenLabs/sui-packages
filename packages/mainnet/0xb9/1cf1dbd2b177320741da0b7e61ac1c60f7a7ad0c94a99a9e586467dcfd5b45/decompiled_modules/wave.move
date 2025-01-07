module 0xb91cf1dbd2b177320741da0b7e61ac1c60f7a7ad0c94a99a9e586467dcfd5b45::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 6, b"WAVE", b"Wave", b"$WAVE is a legendary underwater creature that protects the entire ecosystem in the SUI world. $WAVE can transform into anything, and like a ghost, he can also be invisible. The tidal WAVES that are pumped indicate his presence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/buy_Recovered_b5a40ad786.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

