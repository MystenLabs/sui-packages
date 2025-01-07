module 0x42cf407272ca240ec4bb88e090319cd891af2559109e9152f8d61914316c890b::b1coin {
    struct B1COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B1COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B1COIN>(arg0, 6, b"B1COIN", b"B1COIN ON SUI", b"b1coin is dedicated to the idea of making money from crypto to buy a Lamborghini.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Frame_99_9040da360e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B1COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B1COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

