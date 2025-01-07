module 0x753bcafbb7e35f8a139a8999544ae11a5df1a8e936c38c9bece8a50befe0566::suicatfood {
    struct SUICATFOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATFOOD>(arg0, 6, b"Suicatfood", b"Sui-branded cat food", b"Sui brand cat food is now on the market  If you come for the king, you better not miss.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240925143027_25ae1f5508.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATFOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATFOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

