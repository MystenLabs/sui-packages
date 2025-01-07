module 0x723d07612df69aa37e16faef4dc5b3441285d237d227575de599a43d0647519e::moji {
    struct MOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJI>(arg0, 6, b"MOJI", b"MOJI SUI", x"244d4f4a49205468652042696720507572706c6520456d6f6a690a5374617274696e672074686520656d6f6a692d6669206d657461206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241213_154025_480_f60780ab67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

