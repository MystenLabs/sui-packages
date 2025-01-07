module 0x2e758722fb7ab13ee592361f5a6c6eab76ca3dcb06663ab4dedbf38b6ee1b6ef::pinky {
    struct PINKY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PINKY>, arg1: 0x2::coin::Coin<PINKY>) {
        0x2::coin::burn<PINKY>(arg0, arg1);
    }

    fun init(arg0: PINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKY>(arg0, 9, b"PINKY", b"Pinky the Pineapple", b"Pinky the Pineapple", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUBahjmAnrGwWDRGEtxcdnE4owkrKLc6D9uNxrXNgJhtG")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINKY>(&mut v2, 9000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

