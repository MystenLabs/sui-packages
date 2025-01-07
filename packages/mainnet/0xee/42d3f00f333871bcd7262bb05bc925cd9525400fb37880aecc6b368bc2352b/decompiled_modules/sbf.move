module 0xee42d3f00f333871bcd7262bb05bc925cd9525400fb37880aecc6b368bc2352b::sbf {
    struct SBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBF>(arg0, 6, b"SBF", b"Sbf", b"Make the crypto world strong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730471412422.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

