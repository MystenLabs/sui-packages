module 0x3ad7dc24d757cd64d145668bf5821369faf5b36a3dbe263673db10e5522e6953::dogu {
    struct DOGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGU>(arg0, 6, b"DOGU", b"Dogucoin", b"Dogu, the meme dog coin on the Sui Network, is here to bring purrs and laughs to your crypto advantures!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih6idm5kvun6yt42mjsqjldpxiyvufy62qux7ayjw57lmfyu3ik2m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

