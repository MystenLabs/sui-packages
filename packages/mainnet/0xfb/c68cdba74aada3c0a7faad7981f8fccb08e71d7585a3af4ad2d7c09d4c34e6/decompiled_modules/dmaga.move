module 0xfbc68cdba74aada3c0a7faad7981f8fccb08e71d7585a3af4ad2d7c09d4c34e6::dmaga {
    struct DMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMAGA>(arg0, 9, b"DMAGA", b"DARK MAGA", b"Dark MAGA' movement dreams of a vengeful Trump destroying his enemies, and is using 'meme warfare.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x5640e0560e6afd6a9f4ddb41230d0201d181fea7.png?size=lg&key=cb85ec")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DMAGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMAGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

