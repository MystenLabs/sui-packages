module 0x27fed7f53a41527b91972c4c4d4a5e8482348063f6239e249d1a65f456a373ac::eit {
    struct EIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EIT>(arg0, 9, b"EIT", b"EARNING", b"Earning info Tech", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7403bae1-b968-43ad-821d-914423020305.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

