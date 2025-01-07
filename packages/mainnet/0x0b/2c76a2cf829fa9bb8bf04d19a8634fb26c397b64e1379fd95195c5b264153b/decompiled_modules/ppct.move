module 0xb2c76a2cf829fa9bb8bf04d19a8634fb26c397b64e1379fd95195c5b264153b::ppct {
    struct PPCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPCT>(arg0, 6, b"Ppct", b"Popcat", b"Popcat Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949834283.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

