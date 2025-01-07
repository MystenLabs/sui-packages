module 0x619d0b607f668ebb1b3b2593b7f935168677c657047e94225954ea51acec1a42::mcm {
    struct MCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCM>(arg0, 6, b"MCM", b"MerCatMan", b"Part mermaid, part cat, part man. A hero of the SUI, with a strange family tree.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000114641_a8da5bc96c_ef8f39ac0e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

