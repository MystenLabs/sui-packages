module 0xfc81280df90bc0067ba2d241bc5702aa5c13c59f3ac8afe97fee3fbdca819021::murkz {
    struct MURKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURKZ>(arg0, 6, b"MURKZ", b"MurkzOnSui", b"Been on $MURKZ since a long time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_175323_6c2b5fcde6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

