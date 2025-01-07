module 0xd6040cecc8397a91cc25ae30ff453c48b0ea26b4ae013e4dda846c792bfdfe0f::pepay {
    struct PEPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPAY>(arg0, 6, b"PEPAY", b"Pepay", b"PEPAY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/af9_Vx7vp_400x400_7126a520b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

