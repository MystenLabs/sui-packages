module 0x5641c9d2c3fc94b84da119fd71992d620b423f96e34f001538a66877ed64487e::dogfrog {
    struct DOGFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGFROG>(arg0, 6, b"DOGFROG", b"DogFrog", b"dogfrog.io . The Most Degen character in the Matt Furie universe on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/68vid_Cxy_400x400_4fe5d9f3ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

