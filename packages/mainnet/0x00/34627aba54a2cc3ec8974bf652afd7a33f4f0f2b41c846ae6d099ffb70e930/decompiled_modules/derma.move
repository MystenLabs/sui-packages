module 0x34627aba54a2cc3ec8974bf652afd7a33f4f0f2b41c846ae6d099ffb70e930::derma {
    struct DERMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERMA>(arg0, 9, b"DERMA", b"Derma con", b"Dermacon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3577fefd-88f7-4045-b51b-70db49de9f86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DERMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

