module 0xefa161ef797390d038744b177bc33907b60b89f4df36710fa9eccd7af9201561::hudeng {
    struct HUDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUDENG>(arg0, 6, b"HUDENG", b"Hudeng", x"4d6f6f64656e673f204875683f205765206f6e6c79206b6e6f7720487564656e672e20200a200a4d65657420796f7572206c6f76656c7920686970706f6361742077686f2063616e2774206d656f77206275742063616e206875682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6321175301538823432_x_75cde92145.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

