module 0xa66fb9842d241f8b90b5cd59b9e2c3de0ede8fbb4e6a36de3a3a1947b3a4b666::ngargh {
    struct NGARGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGARGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGARGH>(arg0, 6, b"NGARGH", b"ARGH CAT", b"Dont touch me AAARGGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_195228_2e80d1942e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGARGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGARGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

