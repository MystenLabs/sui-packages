module 0x423b86279133722ee1d11b7a07fc94d80c1f31142d15352e79f57c087d15916c::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CAPY>(arg0, 9, 0x1::string::utf8(b"CAPY"), 0x1::string::utf8(b"Capy"), 0x1::string::utf8(b"The chill capybara of the SUI waters. Semi-aquatic, unbothered, 1B supply. No tax. No presale. Pure vibes."), 0x1::string::utf8(b"https://coral-known-gayal-546.mypinata.cloud/ipfs/bafybeihz2f6dqijhea5nllsxknu4glrpxxpv25ayahuuaroysgsdysufly"), arg1);
        let v2 = v1;
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<CAPY>>(0x2::coin_registry::finalize<CAPY>(v0, arg1));
        0x2::coin::mint_and_transfer<CAPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAPY>>(v2);
    }

    // decompiled from Move bytecode v6
}

