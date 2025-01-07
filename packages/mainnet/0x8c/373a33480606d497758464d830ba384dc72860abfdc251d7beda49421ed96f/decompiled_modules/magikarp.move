module 0x8c373a33480606d497758464d830ba384dc72860abfdc251d7beda49421ed96f::magikarp {
    struct MAGIKARP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGIKARP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGIKARP>(arg0, 9, b"magikarp", b"Magikarp", b"pokemonking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Ftwitter.com%2FMeotis_%2Fstatus%2F1482002891850268677&psig=AOvVaw3z5s4mCUwgoSJXKaVOfOrp&ust=1727402036712000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCMDR3cjA34gDFQAAAAAdAAAAABAE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGIKARP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGIKARP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGIKARP>>(v1);
    }

    // decompiled from Move bytecode v6
}

