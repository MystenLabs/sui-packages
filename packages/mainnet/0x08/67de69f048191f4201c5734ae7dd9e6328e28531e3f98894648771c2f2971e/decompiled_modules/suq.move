module 0x867de69f048191f4201c5734ae7dd9e6328e28531e3f98894648771c2f2971e::suq {
    struct SUQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUQ>(arg0, 6, b"SUQ", b"SUQ Life", b"The community coin of tSUInami chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/warren_smith_4fdc798378.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

