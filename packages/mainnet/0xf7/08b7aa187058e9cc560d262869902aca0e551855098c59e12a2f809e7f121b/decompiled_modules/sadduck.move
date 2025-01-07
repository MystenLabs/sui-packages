module 0xf708b7aa187058e9cc560d262869902aca0e551855098c59e12a2f809e7f121b::sadduck {
    struct SADDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADDUCK>(arg0, 6, b"SADDUCK", b"SAD DUCK", b"Finding Mom and Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Salinan_dari_Desain_Tanpa_Judul_5_removebg_preview_6cba897923.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

