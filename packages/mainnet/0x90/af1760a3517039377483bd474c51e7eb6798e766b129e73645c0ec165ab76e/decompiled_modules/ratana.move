module 0x90af1760a3517039377483bd474c51e7eb6798e766b129e73645c0ec165ab76e::ratana {
    struct RATANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATANA>(arg0, 6, b"RATANA", b"Sui Ratana", b"Welcome to Ratana  - a meme coin built on trust and community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016115_8bed358236.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

