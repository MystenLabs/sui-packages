module 0xb2cc3405ac6655b4facfc0837bb12e3116f88418ae81de29a381c20dcb9875db::eeed {
    struct EEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEED>(arg0, 6, b"EEED", b"eee dolphin", b"EeeEEEeeeEEEeeeEEEeeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4448_2d2bbd728c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

