module 0x38a9a900874655b83e4aac9fdaccf428f7afb36dea3951d46d8485c94e9e1b3d::raccoons {
    struct RACCOONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACCOONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACCOONS>(arg0, 9, b"Raccoons", b"Raccoons", b"Love Raccoons Love Sui Love Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840470119702499328/d1ZM-HS7_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RACCOONS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACCOONS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACCOONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

