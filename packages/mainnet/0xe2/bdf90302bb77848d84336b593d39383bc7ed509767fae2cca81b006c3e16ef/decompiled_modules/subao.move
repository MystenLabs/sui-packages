module 0xe2bdf90302bb77848d84336b593d39383bc7ed509767fae2cca81b006c3e16ef::subao {
    struct SUBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBAO>(arg0, 6, b"SUBAO", b"suifubao", b"Meet Asias most loved Fu Bao at Sui Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_22_21_34_35_cf2f0a348c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

