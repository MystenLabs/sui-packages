module 0xbd11305e8386ff62f3e773c8530580bb9b07be0f37f1458f3447b0ba572a669a::flipgirl {
    struct FLIPGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIPGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIPGIRL>(arg0, 9, b"FLIPGIRL", b"Flip Titty Girl", b"hawk tuah girl, get out hereFlip titty girl has officially arrived!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZDXd785Acn4HUTnudDCC9ZR811HAywXPV9TLy5ydqywe")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLIPGIRL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLIPGIRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIPGIRL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

