module 0x834b444d8f0ceeec6c1a9e08cdfbe57854169566db5574f500b47b1eb282c8ef::seol {
    struct SEOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEOL>(arg0, 6, b"SEOL", b"Sui Seol", b"$SEOL is on a mission to rule on SUI together, forever (with 1billion frens)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048072_02cfbb6151.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

