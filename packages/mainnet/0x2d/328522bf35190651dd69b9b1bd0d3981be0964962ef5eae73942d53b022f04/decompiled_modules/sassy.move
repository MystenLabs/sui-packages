module 0x2d328522bf35190651dd69b9b1bd0d3981be0964962ef5eae73942d53b022f04::sassy {
    struct SASSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASSY>(arg0, 6, b"SASSY", b"First Sassy The Sasquatch on Sui", b"First Sassy The Sasquatch On Sui : https://sassycoin.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/48b9d0_2c110f285cca4089abdf4794ef66cba1_mv2_2_19a1802137.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

