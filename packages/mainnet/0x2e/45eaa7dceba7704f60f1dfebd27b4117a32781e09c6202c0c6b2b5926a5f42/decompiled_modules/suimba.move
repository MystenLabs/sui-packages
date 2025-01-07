module 0x2e45eaa7dceba7704f60f1dfebd27b4117a32781e09c6202c0c6b2b5926a5f42::suimba {
    struct SUIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMBA>(arg0, 6, b"SUIMBA", b"Suimba", b"Meet Suimba, the most adorable mascot of the Sui Network. Suimba is a young, light blue lion who embodies courage and adventure, destined for the throne and to guide the Sui community to greatness!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/URF_5_b9efcec9ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

