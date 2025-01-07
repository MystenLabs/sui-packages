module 0xd2386af92ff44befe36a769b6369e9a2eae56371c3a744c70aa97d75aa86dcb9::pepetc {
    struct PEPETC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPETC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPETC>(arg0, 6, b"PEPETC", b"PEPE THE CHAD", b"Pepe the Chad is back! More powerful and pumped up, ready to dominate the crypto scene.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepe_d0cafaa95e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPETC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPETC>>(v1);
    }

    // decompiled from Move bytecode v6
}

