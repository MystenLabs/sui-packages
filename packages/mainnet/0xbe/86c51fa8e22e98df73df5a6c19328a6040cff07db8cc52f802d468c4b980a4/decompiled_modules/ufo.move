module 0xbe86c51fa8e22e98df73df5a6c19328a6040cff07db8cc52f802d468c4b980a4::ufo {
    struct UFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFO>(arg0, 6, b"UFO", b"SUIUFO", b"Bull Run Vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8686_82ef739c17.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

