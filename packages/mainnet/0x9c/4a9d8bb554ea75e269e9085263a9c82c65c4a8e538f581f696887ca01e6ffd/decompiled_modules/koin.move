module 0x9c4a9d8bb554ea75e269e9085263a9c82c65c4a8e538f581f696887ca01e6ffd::koin {
    struct KOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOIN>(arg0, 6, b"KOIN", b"Kittekoin", b"The wurrldd furst, last and only inturrnet resurrve krypto-purrency   ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ard_KC_Ql_W_400x400_3609a5b942.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

