module 0x8a68f7b856af35567b312f438985351c61a423ec7b52143b943d113e449daa62::wer {
    struct WER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WER>(arg0, 9, b"WER", b"wer", b"wer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreic5rvww44r365h66omnrhxft5fsz7v4cliq45xbiv4d4g7isbl7sm?X-Algorithm=PINATA1&X-Date=1736745807&X-Expires=315360000&X-Method=GET&X-Signature=217a4bd9126b9e1f6ce21b0cdf90cf9997f6c15469a3b2888729dcb569149a17"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WER>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WER>>(v2);
    }

    // decompiled from Move bytecode v6
}

