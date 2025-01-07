module 0x3f32ecbe1e394ba5e44d80f63a2331b6e99158ff28fb5d1a297c26099fca7275::bbc {
    struct BBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBC>(arg0, 6, b"BBC", b"BBC only", b"bbc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950250449.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

