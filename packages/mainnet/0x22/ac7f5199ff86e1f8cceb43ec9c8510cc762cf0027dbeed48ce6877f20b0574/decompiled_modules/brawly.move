module 0x22ac7f5199ff86e1f8cceb43ec9c8510cc762cf0027dbeed48ce6877f20b0574::brawly {
    struct BRAWLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAWLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAWLY>(arg0, 6, b"BRAWLY", b"Brawly on Sui", b"Brawly on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029021_5162c8a610.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAWLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAWLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

