module 0xd395bcc6be0d6578d3dc97b9b89209cd9f3766a592e7c247abceb4ccd9bc7c4::salmoon {
    struct SALMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMOON>(arg0, 6, b"SALMOON", b"SALMOON ON SUI", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_03_at_00_58_04_salmon_meme_Recherche_Google_14009a83b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

