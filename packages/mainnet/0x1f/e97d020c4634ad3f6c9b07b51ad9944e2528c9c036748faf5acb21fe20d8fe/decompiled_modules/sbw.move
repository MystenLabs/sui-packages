module 0x1fe97d020c4634ad3f6c9b07b51ad9944e2528c9c036748faf5acb21fe20d8fe::sbw {
    struct SBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBW>(arg0, 6, b"SBW", b"Sui BigWhale", b"Whales come to sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_L_Oyf2h_400x400_23abdffc3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBW>>(v1);
    }

    // decompiled from Move bytecode v6
}

