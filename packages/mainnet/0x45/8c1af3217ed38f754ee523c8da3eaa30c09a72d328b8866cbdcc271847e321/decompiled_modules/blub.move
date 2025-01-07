module 0x458c1af3217ed38f754ee523c8da3eaa30c09a72d328b8866cbdcc271847e321::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 9, b"BLUB", b"BLOOB", b"BLOOB Token is a meme coin on the Sui blockchain, offering fast, fee-free transactions and community-driven meme contests, with exclusive NFT rewards for holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1580340146414780416/iv5Ue9qr.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUB>(&mut v2, 310000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

