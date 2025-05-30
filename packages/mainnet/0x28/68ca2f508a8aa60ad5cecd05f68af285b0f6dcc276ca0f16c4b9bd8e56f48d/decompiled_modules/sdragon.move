module 0x2868ca2f508a8aa60ad5cecd05f68af285b0f6dcc276ca0f16c4b9bd8e56f48d::sdragon {
    struct SDRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRAGON>(arg0, 6, b"SDragon", b"Sui Dragon", b"Introducing SuiDragon, the blazing hot new meme token taking the crypto world by storm! Inspired by the mythical and powerful dragon, SuiDragon soars into the market as the token of choice for 2024, the auspicious year of the dragon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1531728902482_pic_174cb8f4fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

