module 0x6a8f1c5775016aa5ac1c0ad8df2334c99776a75f9f87e6c689bf35371fa489c9::sori {
    struct SORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORI>(arg0, 6, b"sori", b"SUI DORI", b"SORI is a meme token on Sui, inspired by Dori.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ik.imagekit.io/qsp1f71zd/sori.jpeg?updatedAt=1728605026491"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SORI>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

