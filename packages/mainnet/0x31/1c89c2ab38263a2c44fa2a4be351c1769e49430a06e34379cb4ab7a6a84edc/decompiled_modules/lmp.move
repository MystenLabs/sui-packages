module 0x311c89c2ab38263a2c44fa2a4be351c1769e49430a06e34379cb4ab7a6a84edc::lmp {
    struct LMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMP>(arg0, 6, b"LMP", b"lampatar", b"LAMPLAMPLAMPLAMPLAMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54_52039488ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

