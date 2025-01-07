module 0x1c9269caab4fe23531fec239d5b99e3c5ae973702d32f6e58cafacc01cef4f77::trolli {
    struct TROLLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLI>(arg0, 6, b"TROLLI", b"Trolli On Sui", b"Trolli is 6ix9ine's dog in real life, and a memecoin that's about to shake up crypto with a bark and a bite! In the world of Trolli, every day is a green day, nigga!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_de5530f181.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROLLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

