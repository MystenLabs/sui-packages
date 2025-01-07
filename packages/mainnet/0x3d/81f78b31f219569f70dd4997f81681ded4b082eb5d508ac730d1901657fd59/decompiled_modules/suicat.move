module 0x3d81f78b31f219569f70dd4997f81681ded4b082eb5d508ac730d1901657fd59::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 9, b"SUICAT", b"SuiCat", b"SuiCat is a meme token on the Sui blockchain, offering fast, low-fee transactions and DeFi opportunities, blending fun with financial potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/doesntgiveaf1/status/1829594670114169002?t=9tUTHHApZZRdgBgYishofg&s=19")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICAT>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

