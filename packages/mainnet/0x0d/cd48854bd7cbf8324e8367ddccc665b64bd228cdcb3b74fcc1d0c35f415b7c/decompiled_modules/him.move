module 0xdcd48854bd7cbf8324e8367ddccc665b64bd228cdcb3b74fcc1d0c35f415b7c::him {
    struct HIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HIM>(arg0, 6, b"HIM", b"HIMSUI", b"Be extra in a world of ordinary.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000007754_bd6a3bb1cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

