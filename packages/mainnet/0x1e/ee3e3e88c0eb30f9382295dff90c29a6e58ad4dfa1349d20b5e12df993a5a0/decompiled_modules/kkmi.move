module 0x1eee3e3e88c0eb30f9382295dff90c29a6e58ad4dfa1349d20b5e12df993a5a0::kkmi {
    struct KKMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKMI>(arg0, 9, b"KKMI", b"Kokomi", b"The young Divine Priestess of Watatsumi Island and a descendant of the Sangonomiya Clan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85ff801f-6140-40e6-929c-3c8c45f8ab5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

