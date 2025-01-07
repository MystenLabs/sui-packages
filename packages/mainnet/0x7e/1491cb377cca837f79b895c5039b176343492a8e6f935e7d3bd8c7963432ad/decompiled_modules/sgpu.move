module 0x7e1491cb377cca837f79b895c5039b176343492a8e6f935e7d3bd8c7963432ad::sgpu {
    struct SGPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGPU>(arg0, 6, b"SGPU", b"SUI GPU", b"Let money make itself while we sleep. Come to SUIGPU (SPGU)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIGPU_8a2a84f50b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

