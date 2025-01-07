module 0xcf6ce99a28c864c8a4b203cfb49cbcef92d726bb2a656a966abb34c1c59d0ed5::symp {
    struct SYMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYMP>(arg0, 6, b"SYMP", b"Symphony", x"49206a7573742077616e6e612062652070617274206f6620796f75722073796d70686f6e790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/91i10d_2791c3b61b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

