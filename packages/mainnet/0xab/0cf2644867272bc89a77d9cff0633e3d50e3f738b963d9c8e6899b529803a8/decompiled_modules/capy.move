module 0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 9, b"CAPY", b"Capy", b"The chill capybara of the SUI waters. Semi-aquatic, unbothered, 1B supply. No tax. No presale. Pure vibes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coral-known-gayal-546.mypinata.cloud/ipfs/bafybeihz2f6dqijhea5nllsxknu4glrpxxpv25ayahuuaroysgsdysufly")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPY>>(v1);
        0x2::coin::mint_and_transfer<CAPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAPY>>(v2);
    }

    // decompiled from Move bytecode v6
}

