module 0xd4e852046329ff822dba465d0dd2354748996e58ec0641b68cd67ee01e105915::arcs {
    struct ARCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCS>(arg0, 6, b"ARCS", b"ANGRYCROW", b"AngryCrow wishes you a great experience here !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_615b5b573b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

