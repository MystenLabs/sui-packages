module 0x30ef8374de27be8233fc0a35286f1ed11c12efb1cdd4c9445d77a8b8769fbed6::bamboo {
    struct BAMBOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAMBOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAMBOO>(arg0, 9, b"Bamboo", b"Bamboo Token", b"Bambo Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775591372779-a6a8f1f74e7802d3215c998ef3421ad4.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BAMBOO>>(0x2::coin::mint<BAMBOO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAMBOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMBOO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

