module 0xee0b6a1c9728604ab9e6074af3af6160987e1eff45a5cd6af9c55ff54f55ce62::ddog {
    struct DDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDOG>(arg0, 6, b"DDOG", b"Deadpool Dog", b"Welcome to deadpool Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7300_a90b12b446.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

