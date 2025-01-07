module 0x302a050a761b6d8a9cd46fdd2de83001e3abe3abf907186ed9d905e423b4db92::gui {
    struct GUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUI>(arg0, 9, b"GUI", x"47554920494e55e298a0efb88f", b"$GUI INU is the #1 community token on #SUI. Made by the community, for the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1736412271838969856/HgcDMf8N_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

