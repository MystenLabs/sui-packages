module 0xd4d645c0baed9899b55d203e20c3ed47b31e234052e8b563ef7df8d7364e592::pdd {
    struct PDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDD>(arg0, 9, b"PDD", b"pudidi", b"bggdgg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0383cf6-66aa-423e-b420-5bd3906c9c0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

