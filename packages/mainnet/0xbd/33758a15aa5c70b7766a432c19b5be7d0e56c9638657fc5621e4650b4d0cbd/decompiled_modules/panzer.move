module 0xbd33758a15aa5c70b7766a432c19b5be7d0e56c9638657fc5621e4650b4d0cbd::panzer {
    struct PANZER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANZER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANZER>(arg0, 6, b"PANZER", b"Panzerdogs", b"PVP play & earn tank brawler on #sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9682_eb97679eb6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANZER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANZER>>(v1);
    }

    // decompiled from Move bytecode v6
}

