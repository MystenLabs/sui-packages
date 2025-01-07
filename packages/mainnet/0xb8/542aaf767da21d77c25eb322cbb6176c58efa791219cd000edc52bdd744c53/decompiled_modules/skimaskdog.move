module 0xb8542aaf767da21d77c25eb322cbb6176c58efa791219cd000edc52bdd744c53::skimaskdog {
    struct SKIMASKDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIMASKDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIMASKDOG>(arg0, 6, b"SKIMASKDOG", b"SKI MASK DOG ON SUI", b"The Sui Wif", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006286_54604a87b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIMASKDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIMASKDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

