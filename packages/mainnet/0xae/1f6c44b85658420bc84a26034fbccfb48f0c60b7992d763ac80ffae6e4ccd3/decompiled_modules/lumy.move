module 0xae1f6c44b85658420bc84a26034fbccfb48f0c60b7992d763ac80ffae6e4ccd3::lumy {
    struct LUMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMY>(arg0, 6, b"LUMY", b"Sui Lumy AI", b"Lumy is an adorable and intelligent virtual kitten, designed to bring together technology and cuteness in perfect harmony. With its glowing neon blue fur and large, expressive eyes, Lumy captivates everyone with its warm and friendly presence. It holds a futuristic coin featuring a droplet and flame symbol, representing its role as a reliable and innovative digital companion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e9625284_f615_48f3_a445_afbb86f6eda1_1_ca10e12046.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

