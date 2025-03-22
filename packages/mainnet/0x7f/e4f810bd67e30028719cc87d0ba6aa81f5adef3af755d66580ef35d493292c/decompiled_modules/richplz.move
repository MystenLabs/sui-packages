module 0x7fe4f810bd67e30028719cc87d0ba6aa81f5adef3af755d66580ef35d493292c::richplz {
    struct RICHPLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHPLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHPLZ>(arg0, 9, b"Richplz", b"Richplease", b"uhmmm... let's get rich?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ed28fdf28a957cb9cd9bde67f6808b45blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICHPLZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHPLZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

