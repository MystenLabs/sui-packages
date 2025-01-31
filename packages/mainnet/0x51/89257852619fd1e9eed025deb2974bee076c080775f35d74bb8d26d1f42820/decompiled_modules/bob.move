module 0x5189257852619fd1e9eed025deb2974bee076c080775f35d74bb8d26d1f42820::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"Bob by SuiAI", b"Bob, He builds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Renegades_2019_allmode_cd58f11a16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

