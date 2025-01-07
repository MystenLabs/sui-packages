module 0x7d366ad4a8fde08e2c2335f1d006b68dd08fb44b6c4e39077d052bffbd21b647::ddd {
    struct DDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDD>(arg0, 6, b"DDD", b"DEGEN DARK DOGE", b"Dark Doge is possible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xd20ee2f7410140a1931d51ef072a1f8765e3a34c_08717dba09.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

