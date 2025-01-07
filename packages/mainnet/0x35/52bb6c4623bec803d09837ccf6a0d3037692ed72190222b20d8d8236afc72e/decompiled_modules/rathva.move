module 0x3552bb6c4623bec803d09837ccf6a0d3037692ed72190222b20d8d8236afc72e::rathva {
    struct RATHVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATHVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATHVA>(arg0, 9, b"RATHVA", b"Mongo", b"Muje Aacha laga ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c86657f3-e5f7-4c02-98da-a1bc49c8113d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATHVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATHVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

