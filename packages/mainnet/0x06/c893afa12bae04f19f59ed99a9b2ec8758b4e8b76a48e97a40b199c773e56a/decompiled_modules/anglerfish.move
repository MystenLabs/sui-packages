module 0x6c893afa12bae04f19f59ed99a9b2ec8758b4e8b76a48e97a40b199c773e56a::anglerfish {
    struct ANGLERFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGLERFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGLERFISH>(arg0, 6, b"ANGLERFISH", b"Black Devil", b"Did you realise how huge these dudes are?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_16_04_52_06_a4dc9698d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGLERFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGLERFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

