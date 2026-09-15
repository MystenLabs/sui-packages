module 0x7ae1d039b99c5d4ee1aa97a68ac4d6a940601dc07426ad6def56b61dde963274::lucia {
    struct LUCIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Image_9-14-26_at_10.10_PM-bqkWOVQecQ2J9v9bAK8CQ7YOez9Q7C.png";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/Image_9-14-26_at_10.10_PM-bqkWOVQecQ2J9v9bAK8CQ7YOez9Q7C.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<LUCIA>(arg0, 9, b"LUCIA", x"4c55434941e2808b", b"Lucia Caminos is a character due to appear as one of the protagonists in Grand Theft Auto VI.  Lucia debuts as the first major, non-selectable female protagonist with a voice actress. She is often erroneously described as the first female protagonist in the Grand Theft Auto series[2]; Lucia is the eighth female protagonist chronologically, following numerous silent and optional female protagonists in the first Grand Theft Auto, Grand Theft Auto 2 and Grand Theft Auto Online.", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCIA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCIA>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<LUCIA>>(0x2::coin::mint<LUCIA>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

