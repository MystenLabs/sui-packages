module 0xd8ca3f9dc280ba6a3e4763fa75f774f371035c472178b5aaac0a7143d7397b3d::goldkedi {
    struct GOLDKEDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDKEDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDKEDI>(arg0, 6, b"goldkedi", b"MEHMETkedi", b"tewst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1777306322846851073/VunruzU2_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOLDKEDI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDKEDI>>(v2, @0x33b267e87bb2a27a2d0e38671052ba1f57d41912dca265709e68e12e00986591);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDKEDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

