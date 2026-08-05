module 0x8ee0079048416211dfb90748cdfe51cb051bc06956eccb1ef13bd426ed160bf2::locked_fbtc {
    struct LOCKED_FBTC has drop {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        8
    }

    fun init(arg0: LOCKED_FBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LOCKED_FBTC>(arg0, 8, b"lockedFBTC", b"Locked FBTC", b"Regulated omnichain representation of locked FBTC", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCKED_FBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LOCKED_FBTC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOCKED_FBTC>>(v2);
    }

    // decompiled from Move bytecode v6
}

