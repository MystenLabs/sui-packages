module 0x8c3977f59e6267f28f039abb76b345feb5626f831c0e890f9accd316509062f9::catfu {
    struct CATFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFU>(arg0, 6, b"CATFU", b"Catfu", b"Don't mess with the Kitty these paws rated E for everyone ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734314921768.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATFU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

