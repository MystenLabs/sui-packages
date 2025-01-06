module 0x5054e13ff4b328f5885ad1ed7c9f00df7f2d8ee0cb1fce7cb3490afc2bdf0da8::titans {
    struct TITANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITANS>(arg0, 6, b"TITANS", b"Titans on sui", b"Only Titans on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eb8dc9f6_ba69_428a_887f_88e7ce7104c3_ef392e6211.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

