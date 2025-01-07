module 0x7ff93f7c504124fa49d019129becb87d33c6ad36b8787e41c5d71200679fcfc4::bukungs {
    struct BUKUNGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUKUNGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUKUNGS>(arg0, 9, b"BUKUNGS", b"Bukungs ", b"Live large ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/abe05cf8-a859-4b67-98db-7c33d12aa4e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUKUNGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUKUNGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

