module 0x5e9a898ee633ffce00c0cc752d9ccdb5794eb61de740fa0acb2a8934a530617a::suimm {
    struct SUIMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMM>(arg0, 6, b"SUIMM", b"SUIMMING", x"4120776174657220646f6720697320612074797065206f662067756e646f67206272656420746f20666c75736820616e642072657472696576652067616d652066726f6d2077617465722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimming_a488aabcde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

