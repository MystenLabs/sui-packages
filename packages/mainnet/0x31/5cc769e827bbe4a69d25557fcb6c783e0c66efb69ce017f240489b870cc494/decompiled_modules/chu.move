module 0x315cc769e827bbe4a69d25557fcb6c783e0c66efb69ce017f240489b870cc494::chu {
    struct CHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHU>(arg0, 6, b"Chu", b"Churro", b"Churro is a shadow unseen by the world ,until you see him.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_a_dd84a1d033.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

