module 0x5b3a0ae9533a16a4b89de750837cb35d954367f24b7c4062143b0972a4f3ba61::svt {
    struct SVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVT>(arg0, 6, b"SVT", b"SUIVATAR", b"Suivatar: Create a magical creature in the form of an avatar created in the sui blockchain, showing its unique power and charming appearance. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d451a8d6_b860_42e4_9929_38f095553f49_29b27f3f1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVT>>(v1);
    }

    // decompiled from Move bytecode v6
}

