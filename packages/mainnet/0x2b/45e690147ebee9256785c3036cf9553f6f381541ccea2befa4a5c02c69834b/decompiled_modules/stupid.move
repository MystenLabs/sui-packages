module 0x2b45e690147ebee9256785c3036cf9553f6f381541ccea2befa4a5c02c69834b::stupid {
    struct STUPID has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUPID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUPID>(arg0, 9, b"STUPID", b"Steam", b"Steam - the first AI hedge fund for AI projects investment on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3.ap-southeast-1.amazonaws.com/nfts.steampunk.game/coins/steam.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STUPID>>(v1);
        0x2::coin::mint_and_transfer<STUPID>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STUPID>>(v2);
    }

    // decompiled from Move bytecode v6
}

