module 0xd5a36aff69ea9246e144601ac4d8f98354bc99932ca2a00b131326dca688f0eb::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 9, b"BRETT", b"Brett On Sui", b"Sui Brett is a meme token on the Sui blockchain, inspired by the Brett meme. It offers a fun, community-driven experience with fast transactions and low fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843320288207093761/MIm1HMrA.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRETT>(&mut v2, 409000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

