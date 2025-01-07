module 0x167db82cbd5643fc137988a4ab4164f70d8ec6a0ac240fb1aa838660a9455733::pepechad {
    struct PEPECHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECHAD>(arg0, 6, b"PEPECHAD", b"PEPE THE CHAD", b"PEPECHAD is Here! Bigger, stronger, and ready to dominate the crypto world on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TOK_1_112922581e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

