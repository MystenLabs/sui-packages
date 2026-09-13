module 0x72f34f6208f19bbbe6f1ef04f93bf2823325a26bd02c76d57bf8091208f4f90f::koin {
    struct KOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOIN>(arg0, 6, b"KOIN", b"Koi'n", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://koi.family/api/images/0c382f85627d16f473b41abb48f65e854467b50692ba7f1ab1c462ec17e140c4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOIN>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOIN>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

