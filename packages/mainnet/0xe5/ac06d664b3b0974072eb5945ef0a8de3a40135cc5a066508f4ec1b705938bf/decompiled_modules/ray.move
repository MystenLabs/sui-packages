module 0xe5ac06d664b3b0974072eb5945ef0a8de3a40135cc5a066508f4ec1b705938bf::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"RAY on Sui DONT BUY", b"Ray on sui will soon be launching on Move Pump. Don't buy scams, go to our telegram:t.me/rayonsui  and our twitter: https://x.com/RayOnSui for more information.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_22_16_33_17_3f35752977.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

