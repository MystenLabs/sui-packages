module 0xdc2afd1a59f4514790d85313c0224c6925498d381bb975391eb889ba6d81c9d4::soapy {
    struct SOAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAPY>(arg0, 6, b"SOAPY", b"Soapy", b"Join $SOAPY to get clean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WELCOME_cd9e94fd95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

