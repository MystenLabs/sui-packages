module 0x316c634f0a7c9708ec9d0e7cfb6c648d557cc6882fe40949afb1d1658834087c::suicune {
    struct SUICUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUNE>(arg0, 9, b"SUICUNE", b"Suicune", b"We all know who loves the SUICUNE to describe SUI, lets get this on Hsakas radar and pump it to Valhalla!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archives.bulbagarden.net/media/upload/d/dc/0245Suicune.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICUNE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUNE>>(v2, @0xc5aeb9140b6b4b4f43d0f0b754e2079c9e7b8a1ec487df6b631f22494c2b9ed9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

