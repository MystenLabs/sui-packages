module 0x455d4b699524d8c10fd5a7791743781c92a34d9d54d39306443bf5145717a74b::buybinky {
    struct BUYBINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUYBINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUYBINKY>(arg0, 6, b"BUYBINKY", b"Buy BINKY", b"JOIN TG LINKED IN SOCIALS AND LETS BINK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_10e9ded567.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUYBINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUYBINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

