module 0x6a600788e1035492f9945826d7e93e7ef8ec6b398603569edf08df17c810d234::duckinesses {
    struct DUCKINESSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKINESSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKINESSES>(arg0, 9, b"Duckhins", b"duckinesses", b"brag about your duck ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/876481d0-0db7-4d2b-8769-bfb0229e724a.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKINESSES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKINESSES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

