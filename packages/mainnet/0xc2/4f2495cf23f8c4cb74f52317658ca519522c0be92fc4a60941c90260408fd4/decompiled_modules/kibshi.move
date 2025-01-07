module 0xc24f2495cf23f8c4cb74f52317658ca519522c0be92fc4a60941c90260408fd4::kibshi {
    struct KIBSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIBSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIBSHI>(arg0, 6, b"KIBSHI", b"KIBSHI on SUI", x"496620796f7520776f6e646572696e672077686174206973204b49425348492e0a497420697320746865206669727374204d656d6520436f696e2067656e6572617465642062792074686520414921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qoi0yk_x_400x400_b7e96dddc3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIBSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIBSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

