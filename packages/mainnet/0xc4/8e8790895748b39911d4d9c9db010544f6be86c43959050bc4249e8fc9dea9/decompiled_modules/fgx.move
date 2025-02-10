module 0xc48e8790895748b39911d4d9c9db010544f6be86c43959050bc4249e8fc9dea9::fgx {
    struct FGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGX>(arg0, 9, b"FGX", b"GalacticFartGasX", b"In a far-off galaxy, a group of space pirates discovered a planet where the native creatures produced a highly potent gas through their galactic farts. The pirates, realizing the immense value of this gas, began to harvest it and turned it into a valuable trading commodity. The gas, known as GalacticFartGasX, became the most sought-after substance in the universe, leading to a series of hilarious and chaotic intergalactic transactions and disputes. The token represents the rights to this unique and pungent gas, making it a must-have for any serious space investor looking to make a stink in the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739204369/ob2k7b8frwgdci6ammnq.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

