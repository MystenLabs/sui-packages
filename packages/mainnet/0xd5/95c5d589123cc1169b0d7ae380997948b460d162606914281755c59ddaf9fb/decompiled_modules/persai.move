module 0xd595c5d589123cc1169b0d7ae380997948b460d162606914281755c59ddaf9fb::persai {
    struct PERSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERSAI>(arg0, 9, b"PERSAI", b"Persona", b"Privacy-focused AI enabling secure, adaptive blockchain interactions with social tokens. Only with $PERSAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNXvv2vpapaQBu2tF1NUsx1CVHArvtqSSvf4GJyzVYoqK")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PERSAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PERSAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERSAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

