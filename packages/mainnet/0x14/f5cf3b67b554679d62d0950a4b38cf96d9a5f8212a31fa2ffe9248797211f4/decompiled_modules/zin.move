module 0x14f5cf3b67b554679d62d0950a4b38cf96d9a5f8212a31fa2ffe9248797211f4::zin {
    struct ZIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIN>(arg0, 6, b"ZIN", b"Zin", b"ZIN the most memeable cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/43563456_37426ce515.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

