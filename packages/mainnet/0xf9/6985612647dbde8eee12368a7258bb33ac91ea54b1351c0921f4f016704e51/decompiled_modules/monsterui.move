module 0xf96985612647dbde8eee12368a7258bb33ac91ea54b1351c0921f4f016704e51::monsterui {
    struct MONSTERUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSTERUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSTERUI>(arg0, 6, b"MONSTERUI", b"One-eyed monster ", b"I thought it would be fun to see people buy a monster token. HODL and DYOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734962862290.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONSTERUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSTERUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

