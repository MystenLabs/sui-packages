module 0x7a6662d944ccbe6a25f92a5c6527fa22ea4fe84f084b35ee4b8e7ed1e8e7f71f::togi {
    struct TOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOGI>(arg0, 6, b"TOGI", b"Togi catto", x"546f676920746568206a756e676c6520636174746f0a0a524f415221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Togi_The_Jungle_Catto_02_99a4c940c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

