module 0xe2585d1d18ab36a1e890a393ce3440d028cf11a233f8c63352ca7756f24b738::tariffs {
    struct TARIFFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARIFFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARIFFS>(arg0, 6, b"TARIFFS", b"Fuck Tariffs", b"Fuck tariffs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029496_216e834aec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARIFFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARIFFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

