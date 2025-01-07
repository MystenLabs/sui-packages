module 0x88e7ac69760dde27cee6bbd251b7de068c0b8e5add81ad0cb8d5d75dafacda4a::party {
    struct PARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARTY>(arg0, 9, b"PARTY", b"DaddyPartyWifJLO", b"Imagine this wild party on a sui meme going parabolic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1769826295536316417/6-Kf2YVB.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PARTY>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

