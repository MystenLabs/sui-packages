module 0x5c3d5108c954ef2e683b93ec28fb3c70af6704909e303f81da32bd074db92b2::katay {
    struct KATAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATAY>(arg0, 9, b"KATAY", b"TayKatay", b"MemeCat narrative", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30550fef-1b84-48f4-a7bd-92c9abed7a45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KATAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

