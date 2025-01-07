module 0xe23f34470fc9c6807b3f0c216e7b9afd561a47c4807f034d2b946eac8bdf802d::wosh {
    struct WOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOSH>(arg0, 6, b"WOSH", b"WoshDogOnSui", b"$WOSH is not an ordinary dog, cute but strong, intelligent and persistent, he explores the vast plains with his speed. Unlike other dogs that attack without thinking, $WOSH carefully navigates challenges, always looking for opportunities to improve.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001566_87fc56b9ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

