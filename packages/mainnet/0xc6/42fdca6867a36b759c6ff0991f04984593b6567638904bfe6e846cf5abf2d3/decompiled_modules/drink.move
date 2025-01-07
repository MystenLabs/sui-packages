module 0xc642fdca6867a36b759c6ff0991f04984593b6567638904bfe6e846cf5abf2d3::drink {
    struct DRINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRINK>(arg0, 9, b"DRINK", b"Drinkies", b"BEST DRINK IN THE WORLD!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1d8fc631d86dbe9c3d24dcb422703151blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

