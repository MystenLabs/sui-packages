module 0x4571ac185cfbc1be84c45e81eea6d7e2e58f2721b20f09d22b8647780f175c09::angy {
    struct ANGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGY>(arg0, 9, b"ANGY", b"Angela", b"Angela Token (ANG) is a unique, community-driven cryptocurrency designed to bring empowerment and innovation to its holders. Built on transparency and engagement, ANG offers users a chance to participate in governance decisions and access exclusive features within the Angela ecosystem. Whether you're trading or simply holding, Angela Token aims to create a rewarding and inclusive digital experience for all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1834581248808787968/iVdJruhm.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANGY>(&mut v2, 333000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

