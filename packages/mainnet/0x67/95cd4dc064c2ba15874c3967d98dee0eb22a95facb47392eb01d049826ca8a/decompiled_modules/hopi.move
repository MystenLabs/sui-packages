module 0x6795cd4dc064c2ba15874c3967d98dee0eb22a95facb47392eb01d049826ca8a::hopi {
    struct HOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPI>(arg0, 6, b"Hopi", b"SUIHopi", x"5468652068696c6172696f75736c7920636c75656c65737320686970706f2077686f20616c77617973206765747320696e746f207269646963756c6f7573206a756e676c65206d69736861707321200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pc_TJ_8n_D_400x400_a5f5d698dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

