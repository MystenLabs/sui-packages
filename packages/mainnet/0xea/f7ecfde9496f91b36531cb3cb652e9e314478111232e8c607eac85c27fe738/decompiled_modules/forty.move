module 0xeaf7ecfde9496f91b36531cb3cb652e9e314478111232e8c607eac85c27fe738::forty {
    struct FORTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORTY>(arg0, 6, b"FORTY", b"40 Monkeys", b"40 monkeys missed apocalypse opportunity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/40_monkeys_841816d5b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

