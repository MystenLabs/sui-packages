module 0x6513b4d74a8a319c0c5e2774a3dcfa6e49bdbb14c87be4aa0154fd1b6317dbf::pola {
    struct POLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLA>(arg0, 9, b"POLA", b"Pola", b"I'm the coldest, chillest, and funniest bear in the entire Arctic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FPola_Logo_9bf6ecf3f2.png&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POLA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

