module 0xf7bd1f441372f25ae782757cf20cf76f8071ac839b8bb35203c5961bf72bc91b::cryingdog {
    struct CRYINGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYINGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYINGDOG>(arg0, 6, b"Cryingdog", b"cDog", b"I love dogs so I create it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2421_42103a7ddb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYINGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYINGDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

