module 0xa87b0878e9406a4d052d4a982cd209c1f781dda28ecca34fa6e911ed0a276cc9::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"SCUBA CAT", b"I am the only cat that likes diving in the deep blue sui! Starting on Movepump so you don't need to worry as we explore the deep seas! This is the only scuba cat, meow loves you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8359217c001cd427735a3a4e5a981e96_f36be05d45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

