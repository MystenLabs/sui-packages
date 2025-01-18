module 0x30692a5ea3d5dc125880991ce0aad3947df7b64c41aed78075caf69741d01211::ryze {
    struct RYZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYZE>(arg0, 6, b"Ryze", b"RyzeNet", b"Ryze Network is designed to deploy specialized agents for attention tracking, trading, network integration, and management. Built for precision and scalability, it delivers real-time insights,  data processing, and effortless platform interoperabilitygiving you an edge in Web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2179_1ba4a3d238.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RYZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

