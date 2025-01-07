module 0xe5bf0bbb0988828aa7c71bbc9ea9e7cc26e737fd27ffbf2d0cb4f5e2d75821b8::royal {
    struct ROYAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROYAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROYAL>(arg0, 9, b"ROYAL", b"KINGF", b"KING is a meme inspired by the spirit of glory and power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47021644-9683-4b89-8186-8629ee02f745.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROYAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROYAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

