module 0x38e85afc14dc061defd75cf1f3601b94df76f116dc7f4e534a67287bb8ad322e::efmd {
    struct EFMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: EFMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EFMD>(arg0, 6, b"EFMD", b"Efemulated", b"An NFT series depicting strong, feminine archetypes facing objectification and stereotypes. The art highlights women being diminished or undervalued, sparking dialogue on gender dynamics and celebrating resilience. Efemulated reverses \"emasculated\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1756782013038.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EFMD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EFMD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

