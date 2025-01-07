module 0x61bc7e50b8d8baf925da08fe55e22d300b1c8ec4643a22befe521aba3d27afe1::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEME>, arg1: 0x2::coin::Coin<MEME>) {
        0x2::coin::burn<MEME>(arg0, arg1);
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"MEME", b"MEME", b"SUI MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeiateid4viqzyim7yl2glo2skr4gbxou3ksm6bedbkch3nidshkcgq.ipfs.w3s.link/photo_2023-05-04_22-00-47.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEME>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

