module 0xddf27ee3e0fa13a1ba2b240de3c2e50c4ef3ed9081a694dcf488eeadea1c7dd0::tatocto {
    struct TATOCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATOCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATOCTO>(arg0, 6, b"TATOCTO", b"SUITATOCTO", b"Tato, your favorite memecoin on SUI is back!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_8_Uk_1_D_400x400_e83a9a8148.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATOCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATOCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

