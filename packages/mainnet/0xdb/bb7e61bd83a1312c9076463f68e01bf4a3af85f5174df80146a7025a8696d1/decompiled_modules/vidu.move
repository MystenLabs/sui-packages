module 0xdbbb7e61bd83a1312c9076463f68e01bf4a3af85f5174df80146a7025a8696d1::vidu {
    struct VIDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIDU>(arg0, 6, b"VIDU", b"Vidu AI", x"5649445520e2809320546865204c656164696e6720414920566964656f2047656e65726174696f6e20506c6174666f726d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738344060155.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIDU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIDU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

