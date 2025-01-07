module 0x18752e5dc1788426950cb49327edf199df8fe453d1e37a56996748ba001bb215::pim {
    struct PIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIM>(arg0, 6, b"PIM", b"PIM PIMLING", b"Pim is the eternally optimistic and cheerful character from Smiling Friends Inc., where he works alongside his best friend Charlie to spread happiness throughout the world on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pimgif_66392408fa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

