module 0xc8823a606fd9d32735e4d5e8ef3baff4e08e4d8e1abb5764987380fccb2ee331::jellydog {
    struct JELLYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYDOG>(arg0, 9, b"JELLYDOG", b"jelly-my-dog", b"The first memecoin in the JellyJelly App!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfVCwybbVEGKrX1or1rtTsxeU7wMHQyWUJz6kgwExVaEY")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JELLYDOG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JELLYDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

