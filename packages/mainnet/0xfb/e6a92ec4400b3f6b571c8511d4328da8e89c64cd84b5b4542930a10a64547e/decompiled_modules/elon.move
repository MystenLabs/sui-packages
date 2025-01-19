module 0xfbe6a92ec4400b3f6b571c8511d4328da8e89c64cd84b5b4542930a10a64547e::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON>(arg0, 9, b"ELON", b"Official Elon Coin", b"$ELON - The only Elon fan meme-coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXgt6TEGac8Mx8EKKYR9mjjJLmvd9BBVdyRYJzw3kk3mu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

