module 0x72099a3d1eced3afbeb58f8d75404be99b45af3dd326cc9bd510feff68627dee::popcats {
    struct POPCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPCATS>(arg0, 6, b"POPCATS", b"Pop Cat Snake", b"Sssssstrike it Rich with Popcat Snake!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/popcat_snake_01_93a8d867d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

