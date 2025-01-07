module 0x3467a999310ab56166efc460ad3dc09f096fd0a56ead3cb84446165b61436a00::nobail {
    struct NOBAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBAIL>(arg0, 9, b"NOBAIL", b"No bail Daddy", b"Seems no bail for Daddy, but sui to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1775222635862876161/gK2lq9nH.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOBAIL>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBAIL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOBAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

