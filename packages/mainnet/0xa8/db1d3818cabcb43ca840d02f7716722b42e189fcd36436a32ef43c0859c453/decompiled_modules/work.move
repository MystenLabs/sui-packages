module 0xa8db1d3818cabcb43ca840d02f7716722b42e189fcd36436a32ef43c0859c453::work {
    struct WORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORK>(arg0, 6, b"WORK", b"WORK WORK", b"\"They asked me how, I said hard work\" - just a joke of a filthy rich man!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/worklogo_e0cfcfa702.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

