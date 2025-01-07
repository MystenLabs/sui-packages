module 0x4f9a7f9497367fb663ba5333044daf4fe217b0ff4584d0588624a5c488ca7de5::lyora {
    struct LYORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LYORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LYORA>(arg0, 6, b"LYORA", b"Lyoraslime", b"AI - Powered on-chain analytics for targeted growth .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044669_b1f0107b75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LYORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LYORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

