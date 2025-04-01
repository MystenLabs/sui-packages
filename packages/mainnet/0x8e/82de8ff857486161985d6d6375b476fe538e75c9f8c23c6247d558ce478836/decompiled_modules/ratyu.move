module 0x8e82de8ff857486161985d6d6375b476fe538e75c9f8c23c6247d558ce478836::ratyu {
    struct RATYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATYU>(arg0, 9, b"RATYU", b"j65", b"ly8du", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7d3b7aa5bac940ff3cfba6c5d3c74527blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATYU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATYU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

