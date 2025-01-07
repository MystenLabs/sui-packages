module 0xb781a551d9c48738e2a5fd866cb9aa660930c57a6d3cda1514d6fd46cf69dc78::skittlessui {
    struct SKITTLESSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITTLESSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKITTLESSUI>(arg0, 6, b"SKITTLESSUI", b"SKITTLES", b"Hey every one! My name is Skittles! Yes, I am real! I am coming to SUI Network! I have lots of pictures and selfies to share!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6894486575403610509_1_c1ee82024d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKITTLESSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKITTLESSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

