module 0x9c72d79d9b59d6623de8ef768056673025ff1504b23fdd58298ddc69c7b1c73d::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"SUIS", b"SUISAGE", x"546865207461737469657374206d656d6520636f6f6b656420757020696e2074686520535549206b69746368656e2121200a535549534147452069732071756974652073696d706c79206120626c7565207361757361676520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tg_8576460626.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

