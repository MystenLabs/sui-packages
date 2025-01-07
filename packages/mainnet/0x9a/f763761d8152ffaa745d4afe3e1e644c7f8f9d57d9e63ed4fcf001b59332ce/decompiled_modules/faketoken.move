module 0x9af763761d8152ffaa745d4afe3e1e644c7f8f9d57d9e63ed4fcf001b59332ce::faketoken {
    struct FAKETOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKETOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKETOKEN>(arg0, 8, b"FAKETOKEN", b"FAKETOKEN", b"Description for faketoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmUwnbEuDoEKWwq41ry5me7VrGumMsAnTwazdF7AeEhQy7"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FAKETOKEN>(&mut v2, 12000000000000000000, @0x8f6ff638438081e30f3c823e83778118947e617f9d8ab08eca8613d724d77335, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKETOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKETOKEN>>(v2, @0x8f6ff638438081e30f3c823e83778118947e617f9d8ab08eca8613d724d77335);
    }

    // decompiled from Move bytecode v6
}

