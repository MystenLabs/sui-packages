module 0x131791695709c9b5594ec71bd8a657b045dee7d983dc32cc907a5a425c7f8f69::cro {
    struct CRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRO>(arg0, 6, b"CRO", b"Crocodile", b"Crocodiles (family Crocodylidae) or true crocodiles are large semiaquatic reptiles that live throughout the tropics in Africa, Asia, the Americas and Australia. The term crocodile is sometimes used even more loosely to include all extant members of the order Crocodilia, which includes the alligators and caimans (family Alligatoridae), the gharial and false gharial (family Gavialidae) among other extinct taxa.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_776cc0b65d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

