module 0xb823305a9dae6b0fdfdad134a8b5f5378aa37dfed5e5f8a1e422cb608b380a9c::vodka {
    struct VODKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VODKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VODKA>(arg0, 9, b"Vodka", b"Vodka", b"The book of water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Smirnoff_Red_Label_8213.jpg/1200px-Smirnoff_Red_Label_8213.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VODKA>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VODKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VODKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

