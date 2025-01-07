module 0x9d0435f8dd618172db1b8213c5d3bda83c21639b81fbef42fa5c59f22d350be3::paca {
    struct PACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACA>(arg0, 6, b"PACA", b"Sui Alpaca", b"$PACA - Let's make dumb money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500_X500_7_0383c37ebb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

