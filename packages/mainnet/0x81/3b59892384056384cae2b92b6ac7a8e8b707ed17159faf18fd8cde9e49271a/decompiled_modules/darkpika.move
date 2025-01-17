module 0x813b59892384056384cae2b92b6ac7a8e8b707ed17159faf18fd8cde9e49271a::darkpika {
    struct DARKPIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARKPIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARKPIKA>(arg0, 6, b"DARKPIKA", b"DARK PIKACHU", x"596f75277665206a75737420656e74657265642074686520656c65637472696679696e6720776f726c64206f66204461726b2050696b61636875212020200a5768657265206e6f7374616c676961206d65657473206d7973746572792c20616e642074686520626c6f636b636861696e206c69676874732075702077697468207468756e6465726f757320656e657267792e202020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7807_f33f92a4ca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARKPIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARKPIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

