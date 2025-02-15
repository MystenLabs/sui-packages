module 0xa1895f95a2c615e32442e3ac0a6e66df121db51bc8bd6c414178bbd86a2812e3::orac {
    struct ORAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORAC>(arg0, 6, b"ORAC", b"Orac AI Agent", x"4f524143202d207468652066697273742065766572206f70656e2d736f7572636520416c206167656e74207468617420707265646963747320796f7572206675747572652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739584289062.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

