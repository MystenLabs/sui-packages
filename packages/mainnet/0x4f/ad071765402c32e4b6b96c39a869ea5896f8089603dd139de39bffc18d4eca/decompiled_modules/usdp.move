module 0x4fad071765402c32e4b6b96c39a869ea5896f8089603dd139de39bffc18d4eca::usdp {
    struct USDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDP>(arg0, 6, b"USDP", b"USDPSUI", b"USDPSUDPSUIDPSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E26_F60_CA_35_C7_44_FF_95_C6_66_CB_52_BEBE_1_B_c2bda9997a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

