module 0x3de81fd9a72a29820d471e423a1628f29bfae5765f1def1e7ab6c96c184b7a95::sui_pengu {
    struct SUI_PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 615 || 0x2::tx_context::epoch(arg1) == 616, 1);
        let (v0, v1) = 0x2::coin::create_currency<SUI_PENGU>(arg0, 9, b"SPENGU", b"Sui Pengu", b"The token is $SPENGU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreih3o3gnk2f4e5ssnffw6r3pntghfuxzsge2kxhm3wv2epejizcwxi.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_PENGU>(&mut v2, 1000000000000000000, @0x635404724b56af9ddbf28bd8acd12b735b6465360810c438ef54a0152e418af8, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_PENGU>>(v2, @0x635404724b56af9ddbf28bd8acd12b735b6465360810c438ef54a0152e418af8);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_PENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

