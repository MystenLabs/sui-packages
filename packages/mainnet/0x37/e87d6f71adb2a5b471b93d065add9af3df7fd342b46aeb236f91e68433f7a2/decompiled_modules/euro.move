module 0x37e87d6f71adb2a5b471b93d065add9af3df7fd342b46aeb236f91e68433f7a2::euro {
    struct EURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EURO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EURO>(arg0, 6, b"Euro", b"Eurostable", b"A Euro stable coin that will always be stable with Euro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1764695728908.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EURO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EURO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

