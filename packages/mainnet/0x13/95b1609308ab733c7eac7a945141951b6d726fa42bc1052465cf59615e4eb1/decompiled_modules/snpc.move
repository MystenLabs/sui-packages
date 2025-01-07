module 0x1395b1609308ab733c7eac7a945141951b6d726fa42bc1052465cf59615e4eb1::snpc {
    struct SNPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNPC>(arg0, 6, b"SNPC", b"Sui NPC", b"A meme for everyone on the earth. Now it is on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/921_F03_AF_2740_4_FFA_882_E_C587993_A93_A2_2cd7ac7e94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

