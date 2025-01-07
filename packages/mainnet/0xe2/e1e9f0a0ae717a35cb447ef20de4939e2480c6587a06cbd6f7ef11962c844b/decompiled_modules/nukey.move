module 0xe2e1e9f0a0ae717a35cb447ef20de4939e2480c6587a06cbd6f7ef11962c844b::nukey {
    struct NUKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUKEY>(arg0, 6, b"NUKEY", b"NUKEY SUI", b"$NUKEY. The most adorable end-of-the-world memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Np5_VS_Hs_400x400_2ab6b7cf99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

