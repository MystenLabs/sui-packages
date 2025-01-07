module 0xa44f414f9a52ab0d3a8537d26a73f01edccfbf787b2f934f062a5db527c5067c::suibirb {
    struct SUIBIRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIRB>(arg0, 6, b"Suibirb", b"BIRB ON SUI", b"Birb on SUI Netword", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pp4m_Jj6_T_400x400_560eb8a1f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

