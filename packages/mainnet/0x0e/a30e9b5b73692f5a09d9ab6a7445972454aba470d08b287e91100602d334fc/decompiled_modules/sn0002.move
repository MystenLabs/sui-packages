module 0xea30e9b5b73692f5a09d9ab6a7445972454aba470d08b287e91100602d334fc::sn0002 {
    struct SN0002 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SN0002, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SN0002>(arg0, 6, b"Sn0002", b"solana netword", b"solana netword test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726538469856_5e746b0e30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SN0002>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SN0002>>(v1);
    }

    // decompiled from Move bytecode v6
}

