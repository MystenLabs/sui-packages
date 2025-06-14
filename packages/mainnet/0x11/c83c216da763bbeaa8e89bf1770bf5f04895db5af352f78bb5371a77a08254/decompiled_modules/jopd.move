module 0x11c83c216da763bbeaa8e89bf1770bf5f04895db5af352f78bb5371a77a08254::jopd {
    struct JOPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOPD>(arg0, 6, b"JoPD", b"Journey of Pursuing Dreams", b"From here begins my journey in pursuit of dreams, and I hope that all your wishes will be realized step by step! Flowers may bloom again, but one cannot regain their youth! We must not waste this life!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreienhkub6bvihnj45juvnjvboypap2fesft24fywrymfgkbrguhkeu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOPD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

