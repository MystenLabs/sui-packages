module 0x1411d5b65765ec1e1f6a64fc461f5ccee86afe608eda8af9f22ac5e017f86ef6::suicooter {
    struct SUICOOTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOOTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOOTER>(arg0, 6, b"SUICOOTER", b"SuiCooter", b"a cute suicooter on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicooter_4946b46cb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOOTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOOTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

