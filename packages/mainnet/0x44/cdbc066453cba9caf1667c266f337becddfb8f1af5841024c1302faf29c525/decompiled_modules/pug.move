module 0x44cdbc066453cba9caf1667c266f337becddfb8f1af5841024c1302faf29c525::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 6, b"PUG", b"FUD THE PUG", b"Fud the pug, is cutties pug, fudthepug.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3909_75c642d4d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

