module 0x8a0a33046b22ba9a532b637d2350751995c32f9bf886d254cdc0712a0ccd77ad::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 6, b"CHAD", b"GIGA HORSE", b"Saddle up with $CHAD for a wild ride through SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GA_5_Naoy_Wg_AAX_0_Vd_0b009cef75.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

