module 0xed7bc9a62b80974558bd964dea3de544780d00da6d113dc5d28a694f3459e23a::dndmdn {
    struct DNDMDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNDMDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNDMDN>(arg0, 9, b"DNDMDN", b"Tsjwjs", b"Xjxjzj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a414c742-a2ae-4833-9e7a-12701cedaee0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNDMDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNDMDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

