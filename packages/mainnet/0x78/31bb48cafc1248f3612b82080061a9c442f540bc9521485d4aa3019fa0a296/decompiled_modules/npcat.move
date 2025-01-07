module 0x7831bb48cafc1248f3612b82080061a9c442f540bc9521485d4aa3019fa0a296::npcat {
    struct NPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPCAT>(arg0, 6, b"NPCAT", b"NOPARKINGCAT", x"4e4f205041524b494e470a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1728745025759_d9c3a7be73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

