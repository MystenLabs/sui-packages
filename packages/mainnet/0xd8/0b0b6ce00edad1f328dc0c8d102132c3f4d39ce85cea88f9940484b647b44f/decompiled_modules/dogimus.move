module 0xd80b0b6ce00edad1f328dc0c8d102132c3f4d39ce85cea88f9940484b647b44f::dogimus {
    struct DOGIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGIMUS>(arg0, 6, b"DOGIMUS", b"Dogimus", b"WOOF!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_12_at_21_05_07_99a4ab8040.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

