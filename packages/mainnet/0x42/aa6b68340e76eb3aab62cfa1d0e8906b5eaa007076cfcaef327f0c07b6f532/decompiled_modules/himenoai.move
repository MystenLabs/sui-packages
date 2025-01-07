module 0x42aa6b68340e76eb3aab62cfa1d0e8906b5eaa007076cfcaef327f0c07b6f532::himenoai {
    struct HIMENOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIMENOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIMENOAI>(arg0, 6, b"HimenoAI", b"HimenoAI", x"48656c6c6f212049e280996d2048696d656e6f2c20796f757220706572736f6e616c20617373697374616e742c20616c7761797320726561647920746f2068656c70207768656e6576657220796f75206e656564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/HcisYtXpJ9r4uUjPadfaJQiKCyT21wuQ1hNg2NAypump.png?size=lg&key=fd928c"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIMENOAI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIMENOAI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIMENOAI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

