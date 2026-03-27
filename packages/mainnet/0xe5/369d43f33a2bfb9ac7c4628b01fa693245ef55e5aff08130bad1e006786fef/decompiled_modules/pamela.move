module 0xe5369d43f33a2bfb9ac7c4628b01fa693245ef55e5aff08130bad1e006786fef::pamela {
    struct PAMELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAMELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAMELA>(arg0, 6, b"Pamela", b"Pam Pam", b"Token is test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieiuslgnk75sh35oczo5sdgufs24g3ntlmcx2umntz2z4ydk5dihi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAMELA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAMELA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

