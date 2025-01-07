module 0x706fa7723231e13e8d37dad56da55c027f3163094aa31c867ca254ba0e0dc79f::artfi {
    struct ARTFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTFI>(arg0, 9, b"ARTFI", b"ARTFI", b"ARTFI is native coin of artfitoken.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/dG1ec3skYBn7kZ1rWVmiC8QCotv4c7v2FlmQCw4DOgw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARTFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTFI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARTFI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

