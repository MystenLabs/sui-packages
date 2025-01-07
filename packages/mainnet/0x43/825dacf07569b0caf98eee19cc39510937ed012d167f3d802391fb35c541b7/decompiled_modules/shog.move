module 0x43825dacf07569b0caf98eee19cc39510937ed012d167f3d802391fb35c541b7::shog {
    struct SHOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOG>(arg0, 6, b"SHOG", b"SHARK DOG", b"Its a shark thats disguised as a dog I promise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0293_5689388ae9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

