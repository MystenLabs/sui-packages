module 0x986051b75edc4de1220d08509c29d40cbac63b6022db996be6ebe8079adb6376::stevy {
    struct STEVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEVY>(arg0, 9, b"STEVY", b"Steve", b"\"Steve Token Spin Around NFT features a 3D character, Steve, rotating in a loop, showcasing his futuristic design with glowing eyes and digital accessories. The animation reveals intricate details from every angle, creating a dynamic and immersive experience.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1815524613767499776/yn2Y1H7Y.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STEVY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEVY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

