module 0xd664d458bb7f350e238d6773a8ebe2680dd11a4133edd214c839e0c92e8d2291::deprocto {
    struct DEPROCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPROCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPROCTO>(arg0, 6, b"DEPROCTO", b"DEPRESSED OCTOPUS", b"OCTO IS SAD BC CHART DOESNT GO UP. MAKE HIM HAPPY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/depriocto_8fea0e8205.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPROCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEPROCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

