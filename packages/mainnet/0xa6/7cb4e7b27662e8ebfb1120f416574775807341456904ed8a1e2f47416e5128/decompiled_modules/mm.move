module 0xa67cb4e7b27662e8ebfb1120f416574775807341456904ed8a1e2f47416e5128::mm {
    struct MM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM>(arg0, 9, b"MM", b"Medieval Manuscript", b"Create your favourite medieval manuscript memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTLppzqaxqRsAKtEXC53DovbDHAPgTvp3fqqDK4puGCnf")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

