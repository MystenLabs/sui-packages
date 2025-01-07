module 0x795d4bcd12293d98f7d49d3e729db81e9e02d0efa5b6d7faf6e1bf7e61c51310::usdp {
    struct USDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDP>(arg0, 6, b"USDP", b"USDPD", b"USDP ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F6_E5303_B_57_DF_495_D_998_B_0_CDD_73_EE_9361_78f686850c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

