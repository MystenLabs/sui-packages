module 0xa11837d1f839b8f3948a046dfb1c8dd0aa6087db1e7f760b7ea2f7a2b56a3239::dsdeng {
    struct DSDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSDENG>(arg0, 6, b"DSDENG", b"DARK SUIDENG", b"Dark SuiDeng Inspired By Famous Hippo From Thai Zoo $DSDENG ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x420696b7327ba1c4ec12b04906a0e37a36611fca_218c3b9d1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

