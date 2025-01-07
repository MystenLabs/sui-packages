module 0x60c87bb08d1e5bb435f0ce77c1bf523b25f99dd4358c2c6436a88fdc45d9fc92::chase {
    struct CHASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHASE>(arg0, 9, b"CHASE", b"Cory Chase", b"Cory Chase is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.licdn.com/dms/image/v2/D5603AQGjJwziukLG1w/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1696908571056?e=2147483647&v=beta&t=FSmX1ng62lR2-KRI9neg3MYwUp6SERdj0AzkP5K6VC8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHASE>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHASE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

