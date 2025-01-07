module 0x73351bd02a1f75efd52350975e39c26d7dd610b97faaa4cdb0ced5a34ef74561::hatsui {
    struct HATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HATSUI>(arg0, 6, b"Hatsui", b"SuiHat", b"Hat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3524_ab7b230f95.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

