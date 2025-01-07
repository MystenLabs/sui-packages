module 0x48ddc6c6cbb6c1f1e4a0cf7e4687bddfc4b49b04338c5da9a7d6e40210e8b4a3::token_sui {
    struct TOKEN_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_SUI>(arg0, 9, b"BTCat", b"BTCat beating BTC", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bu5fld7zeafvdqkvn6czfadjun54xh4kmkftsgmjc3p6nny4fm7a.arweave.net/DTpVj_kgC1HBVW-FkoBpo3vLn4piizkZiRbf5rccKz4")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN_SUI>>(0x2::coin::mint<TOKEN_SUI>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

