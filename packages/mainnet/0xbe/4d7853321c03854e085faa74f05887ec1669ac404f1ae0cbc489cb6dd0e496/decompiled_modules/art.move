module 0xbe4d7853321c03854e085faa74f05887ec1669ac404f1ae0cbc489cb6dd0e496::art {
    struct ART has drop {
        dummy_field: bool,
    }

    fun init(arg0: ART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ART>(arg0, 9, b"ART", b"Articuno", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://th.bing.com/th/id/OIG3.8VOB62IsJkytl_i_HnDq?w=270&h=270&c=6&r=0&o=5&pid=ImgGn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ART>(&mut v2, 2000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ART>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ART>>(v1);
    }

    // decompiled from Move bytecode v6
}

