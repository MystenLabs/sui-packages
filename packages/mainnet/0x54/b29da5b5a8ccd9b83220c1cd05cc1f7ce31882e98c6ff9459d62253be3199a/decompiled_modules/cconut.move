module 0x54b29da5b5a8ccd9b83220c1cd05cc1f7ce31882e98c6ff9459d62253be3199a::cconut {
    struct CCONUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCONUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCONUT>(arg0, 6, b"Cconut", b"Coconut", b"Who don't like coconut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044828_20d7d6e687.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCONUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCONUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

