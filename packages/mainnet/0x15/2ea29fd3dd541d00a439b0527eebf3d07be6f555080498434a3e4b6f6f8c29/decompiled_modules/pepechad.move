module 0x152ea29fd3dd541d00a439b0527eebf3d07be6f555080498434a3e4b6f6f8c29::pepechad {
    struct PEPECHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECHAD>(arg0, 6, b"PEPECHAD", b"PEPE THE CHAD IN SUI", b"Pepe just unlocked his final form: the Giga Chad. Stronger than ever, this meme coin is a symbol of power, dominance, and meme culture itself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TOK_1_d3cb0615fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

