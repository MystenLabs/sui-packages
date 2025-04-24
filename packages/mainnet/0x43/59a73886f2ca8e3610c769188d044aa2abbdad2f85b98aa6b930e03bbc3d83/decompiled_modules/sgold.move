module 0x4359a73886f2ca8e3610c769188d044aa2abbdad2f85b98aa6b930e03bbc3d83::sgold {
    struct SGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOLD>(arg0, 9, b"TEST2", b"TEST2", b"__Description here__", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"__Url here__")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGOLD>>(v1);
        0x2::coin::mint_and_transfer<SGOLD>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOLD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

