module 0x4436d24f2231515cb54d2cb2c35368c546455390daef8c371f8037f217538a5b::elonsui {
    struct ELONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONSUI>(arg0, 9, b"ELONSUI", b"Official Elon Coin on Sui", b"$ELON - The only Elon fan meme-coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXgt6TEGac8Mx8EKKYR9mjjJLmvd9BBVdyRYJzw3kk3mu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELONSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

