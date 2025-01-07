module 0x29ef0fbb615c28e63fba8d48f24571303f92d9b2e0e9f598e3ad9cc5bfe3f992::dumpcember {
    struct DUMPCEMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMPCEMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMPCEMBER>(arg0, 6, b"DUMPCEMBER", b"DUMPCEMBER SUI", b"JUST A DUMPCEMBER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6309616238875231242_e5c52a3d70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMPCEMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMPCEMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

