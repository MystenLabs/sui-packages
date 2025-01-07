module 0x1ec7a7257e7c804578853f53fcdf2d7f08eeb9252496290cecd2b95ef3f568fc::bullj {
    struct BULLJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLJ>(arg0, 9, b"BULLJ", b"Bulljauwal", b"For upcoming bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b014ba3-ef9d-49dc-83f8-a73a2428ff4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

