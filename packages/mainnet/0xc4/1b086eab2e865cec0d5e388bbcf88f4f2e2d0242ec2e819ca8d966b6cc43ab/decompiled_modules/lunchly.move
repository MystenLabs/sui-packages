module 0xc41b086eab2e865cec0d5e388bbcf88f4f2e2d0242ec2e819ca8d966b6cc43ab::lunchly {
    struct LUNCHLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNCHLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNCHLY>(arg0, 6, b"LUNCHLY", b"Lunchly of Sui", x"4d656574207468652053756920244c554e43484c592c2043686565736520616c7761797320737461797320647269707079206f6e205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/character_40b93a08_4df13a7709.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNCHLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNCHLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

