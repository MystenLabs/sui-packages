module 0x52eef0a7db8c3af7488bce3f35632f8eeeeaaac50ab5ff56d0b26f6f09013032::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUI>(arg0, 6, b"KUI", b"Sharkui", b"We will be the biggest meme on the SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735480411438.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

