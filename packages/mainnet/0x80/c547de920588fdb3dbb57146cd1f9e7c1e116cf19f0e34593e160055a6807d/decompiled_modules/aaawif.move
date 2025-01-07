module 0x80c547de920588fdb3dbb57146cd1f9e7c1e116cf19f0e34593e160055a6807d::aaawif {
    struct AAAWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAWIF>(arg0, 6, b"AAAWIF", b"AAA Dog wif hat", b"AAA dog wif hat is now on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_06_T154447_969_1c91db6dab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

