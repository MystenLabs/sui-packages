module 0x2f03dd1e7e8fcf84f9cf2aca73c4cea2aa7a8911d4c502fd3474ff372c02f9a5::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 9, b"BOB", b"BOB", b"Bob once a fossil, now a king on SUI! | Website: https://linktr.ee/bobonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/874517134babf70669842285e932d9f859c712fd1dd5b368.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

