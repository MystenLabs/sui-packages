module 0x94362d70f88a1ebdedf62394fbd16e16c973331e8fa5a6b9bd1bca25638ed977::suicb {
    struct SUICB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICB>(arg0, 6, b"SuiCB", b"SuiCheeseBall", b"CB on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0338_6e24b7e4e4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICB>>(v1);
    }

    // decompiled from Move bytecode v6
}

