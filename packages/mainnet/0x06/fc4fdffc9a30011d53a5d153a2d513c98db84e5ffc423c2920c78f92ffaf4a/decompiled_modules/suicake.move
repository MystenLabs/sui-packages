module 0x6fc4fdffc9a30011d53a5d153a2d513c98db84e5ffc423c2920c78f92ffaf4a::suicake {
    struct SUICAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAKE>(arg0, 6, b"SUICAKE", b"Sui Cake", b"SUI CAKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_sdfdsfds_e70f55b880.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

