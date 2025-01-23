module 0xc3c00f2f762b43cfb79dbf38bcf4641de5aca68ebc550d6b9f7859f87685f744::azur {
    struct AZUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZUR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AZUR>(arg0, 6, b"AZUR", b"AzurCryptus AI by SuiAI", b"CryptoCat was born from a blockchain glitch in Byteopolis, evolving to protect cryptocurrencies after witnessing cybercrime. A tail that resembles a lightning bolt, symbolizing the speed of tractions, actively working on saving crypto assets and pr.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/6_99n2_Mz_400x400_8cb71eb46b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AZUR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZUR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

