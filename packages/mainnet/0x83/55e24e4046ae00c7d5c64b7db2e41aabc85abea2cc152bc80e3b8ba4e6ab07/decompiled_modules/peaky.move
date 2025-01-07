module 0x8355e24e4046ae00c7d5c64b7db2e41aabc85abea2cc152bc80e3b8ba4e6ab07::peaky {
    struct PEAKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEAKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEAKY>(arg0, 9, b"peaky", b"Peaky", b"A girl in a universe of \"Peaky Blinders\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/users/5638/screenshots/17187751/media/71bfa413480dcf85dbd5d78b685787a7.jpg?resize=800x600&vertical=center")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEAKY>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEAKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEAKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

