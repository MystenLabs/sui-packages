module 0x7a866d958ee0d3ef38a93ddaa75d494528ec6c63db3925f1c40cdcf4fe44b8eb::bor {
    struct BOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOR>(arg0, 6, b"BOR", b"blockjoker", b"\"It symbolizes endless possibilities and an unpredictable future.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240914130749_ea41808903.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

