module 0xcce777b5e636857b4fee073c5e9926deec11b24dcb158da220fee0a08653e530::suijak {
    struct SUIJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJAK>(arg0, 6, b"SUIJAK", b"Suijak", b"The legendary Wojak, now on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_18_33_00_041df413b6_32a48a72e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

