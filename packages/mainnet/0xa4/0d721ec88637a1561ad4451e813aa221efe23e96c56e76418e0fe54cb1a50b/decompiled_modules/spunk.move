module 0xa40d721ec88637a1561ad4451e813aa221efe23e96c56e76418e0fe54cb1a50b::spunk {
    struct SPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUNK>(arg0, 6, b"SPUNK", b"SUI PUNK", b"10,000 NFT collection living on $Sui powered by $PUNK token, created by ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_HJA_5l_Vy_400x400_74e9d85043.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

