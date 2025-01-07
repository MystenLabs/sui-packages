module 0x7db1555ae0c8787e3f2e606162886b1ae7a870f647120ebd0e849c45bf29bed4::scuba {
    struct SCUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUBA>(arg0, 6, b"SCUBA", b"Scuba Dog", b"Scuba Dog On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Scuba_0528333a5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCUBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

