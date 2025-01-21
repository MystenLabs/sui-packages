module 0x92aad4e078dded45773628adc3a9977d546b178bdadabcae351ce1818c5bb1fb::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SC>(arg0, 8, b"SC", b"SC", b"Siamese Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn-aahmh.nitrocdn.com/mwIJloVUffDtKiCgRcivopdgojcJrVwT/assets/images/optimized/rev-31cad3f/www.cozycatfurniture.com/image/Beautiful-Siamese-Cat.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SC>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SC>>(v1);
    }

    // decompiled from Move bytecode v6
}

