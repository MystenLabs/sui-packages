module 0x8058b4a02fad7e04a3c8f2888da2b52381144970412d15665f20a48905fe5978::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILL>(arg0, 6, b"CHILL", b"chill guy who dont gaf", b"when SUI is down but you are a chill guy who lowkey dont gaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.kym-cdn.com/photos/images/newsfeed/002/901/902/95c.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHILL>(&mut v2, 10000000000000000, @0x51fd58dc3f67f3fba25edec90402e8cb317c9d604cb8bf956024b7b63f27161a, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

