module 0x624176031c2c350584c66530f41439783efaba400d62bb07d18935e97c06fc65::trv {
    struct TRV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRV>(arg0, 6, b"TRV", b"TrendVerse", b"\"Stay ahead with TrendVerse, the token that evolves with global trends. Own the future.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732071783368.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

