module 0xb2436dcf8c247ce6e90357e6c5267b28034993745ed40dea74e6d763b0fe706e::shoey {
    struct SHOEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOEY>(arg0, 6, b"SHOEY", b"shoey", b"do a shoey on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWnG3fzKepJdB68iTCjjFJUAyna1BpxmFMxxtGYmqh9ZC?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHOEY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOEY>>(v2, @0x79d95ae0fb4b0615d4a4ef99e0c44e6bebaf969cee264ea6747faec2ad6992a0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

