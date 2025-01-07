module 0x80ac8fd0fdb355bd043b330736204a49aea4e2d591219025b9f203380d553c65::sanchi {
    struct SANCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANCHI>(arg0, 9, b"SANCHI", b"Sanchi the Noel dog", b"Sanchi is a famous dog in instagram. His cosplay photos attracted millions of likes, especially the photos in period of Xmas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2H2r56488VCAsKVJ9kM4WqsmnM7gjikRzS4MkSM4pump.png?size=xl&key=51d339")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SANCHI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANCHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANCHI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

