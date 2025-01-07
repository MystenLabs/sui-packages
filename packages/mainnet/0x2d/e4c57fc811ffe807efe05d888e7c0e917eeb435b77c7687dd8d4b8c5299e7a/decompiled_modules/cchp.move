module 0x2de4c57fc811ffe807efe05d888e7c0e917eeb435b77c7687dd8d4b8c5299e7a::cchp {
    struct CCHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCHP>(arg0, 6, b"CCHP", b"CHATTY CHIPMUNK", b"Non-stop chatter and endless energy. Chatty Chipmunk is hyped and ready to climb.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_033038255_f99bbb2ddc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCHP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

