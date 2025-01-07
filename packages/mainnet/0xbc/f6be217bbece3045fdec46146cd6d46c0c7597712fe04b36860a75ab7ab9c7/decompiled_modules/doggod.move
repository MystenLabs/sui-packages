module 0xbcf6be217bbece3045fdec46146cd6d46c0c7597712fe04b36860a75ab7ab9c7::doggod {
    struct DOGGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGOD>(arg0, 6, b"DOGGOD", b"DogGod", b"Dog god what else", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732058405316.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

