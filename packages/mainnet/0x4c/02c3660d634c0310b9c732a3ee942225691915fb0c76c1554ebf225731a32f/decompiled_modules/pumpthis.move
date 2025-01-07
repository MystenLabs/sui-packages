module 0x4c02c3660d634c0310b9c732a3ee942225691915fb0c76c1554ebf225731a32f::pumpthis {
    struct PUMPTHIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPTHIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPTHIS>(arg0, 6, b"Pumpthis", b"PumpTHIS", b"Lets go ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wallet_hdr_11ca1cf8e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPTHIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPTHIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

