module 0xbb6aa64bf34c2c15fe6540a13ac7178808a7f026cec5dec8c8a77001cfe5114a::flex {
    struct FLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLEX>(arg0, 6, b"FLEX", b"FLEXING DEGEN", x"536f6d65206772696e642c20736f6d6520687573746c652c20736f6d65206c6f736520736c656570206f766572206368617274732e0a0a5765206a7573742077696e2e0a0a5374726174656769632043727970746f20526573657276653f20546f6f20656173792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_3a8754d5df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

