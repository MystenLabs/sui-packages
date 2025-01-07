module 0x523dced0a6b535b3034d685e70b22b133e8fb86974f0b968dd1dc5f94b3f130c::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPY>(arg0, 6, b"HOPPY", b"Hopper the hippo", b"Watch out for Hopper the Hippo this beasts eyes shoot lasers and hes blasting his way straight to the moon!  No chill, all power! Dont get left in his dustHoppers about to take over! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_29_13_27_07_304b346afd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

