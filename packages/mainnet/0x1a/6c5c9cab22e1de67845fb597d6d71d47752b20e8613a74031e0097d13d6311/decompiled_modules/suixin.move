module 0x1a6c5c9cab22e1de67845fb597d6d71d47752b20e8613a74031e0097d13d6311::suixin {
    struct SUIXIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXIN>(arg0, 6, b"Suixin", b"Chinese Sui Fish", b"The chinese fish! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIXIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIN_0931b40741.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIXIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

