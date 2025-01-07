module 0xb442d7341d68f1c32f4058c2638f3b4e43058b5b8a3012fa1473acd98485f85::winner {
    struct WINNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINNER>(arg0, 6, b"WINNER", b"Winner", x"416c6c2069742074616b6573206973206f6e652077696e6e65722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_3b046c765b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

