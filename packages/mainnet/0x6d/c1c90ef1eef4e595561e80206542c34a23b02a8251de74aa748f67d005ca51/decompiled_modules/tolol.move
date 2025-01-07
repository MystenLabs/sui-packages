module 0x6dc1c90ef1eef4e595561e80206542c34a23b02a8251de74aa748f67d005ca51::tolol {
    struct TOLOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOLOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLOL>(arg0, 9, b"TOLOL", b"tolol ", b"just idiot bump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5204352c-eb67-4969-a6c9-257d365392cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOLOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

