module 0xdbe648b35c80e731ede10678f86bb275bf3c31c9b69e7314f518ad964e4914d9::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 9, b"PAPA", b"PapaSui", b"PapaSui is the trusted leader in the Sui ecosystem, providing security and stability for all transactions. As the \"father\" of Sui, it ensures smooth and reliable decentralized finance, making it the go-to token for users and developers alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1704234363112562688/XT6nVqDr.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAPA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

