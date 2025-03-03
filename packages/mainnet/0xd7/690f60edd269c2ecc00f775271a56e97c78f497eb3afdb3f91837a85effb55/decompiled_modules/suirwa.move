module 0xd7690f60edd269c2ecc00f775271a56e97c78f497eb3afdb3f91837a85effb55::suirwa {
    struct SUIRWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRWA>(arg0, 9, b"SUIRWA", b"Sui RWA", b"Sui RWA is connecting AI Agents with the $7.6B industry, driving real-world impact. Tweets are not intended for US, UK, or Canadian audiences.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1877425573443555328/CVzsXUha_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIRWA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRWA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

