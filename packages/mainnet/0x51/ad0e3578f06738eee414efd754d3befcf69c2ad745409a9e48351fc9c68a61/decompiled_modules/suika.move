module 0x51ad0e3578f06738eee414efd754d3befcf69c2ad745409a9e48351fc9c68a61::suika {
    struct SUIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKA>(arg0, 6, b"SUIKA", b"Suikachu", b"https://x.com/Suikachus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/make_a_picture_of_a_blue_pikachu_as_a_logo_for_crypto_with_a_water_droplet_behind_it_hqac75s1sqz63523m9e0_0_7c7f3337d2_43203d0348.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

