module 0xbea05792eff68efd3f56372b1034229cd975c00851d5d040d29ea25eba9aea52::babyplop {
    struct BABYPLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPLOP>(arg0, 9, b"BABYPLOP", b"Baby Plop", b"Baby Plop Plop Plop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1834771477289193472/Q9pntfKR_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYPLOP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPLOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

