module 0x3ecddd39d022dd6d64b8829828178f380451250c730dbaa8da1e141d9a1c703b::sap {
    struct SAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAP>(arg0, 6, b"SAP", b"SuiApesPixels", b"BAPC DAO, PixelApes Collections. Mixing pixelart, bored apes and exclusivity in a single area!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/A74_E4_F8_F_6_E34_4348_B4_C6_C4275488_EA_18_caecf234b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

