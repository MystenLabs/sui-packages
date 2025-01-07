module 0xdb234de7dd085884ef61e589891b1337b9808d633a6c46957c597a2ec5066553::ewe {
    struct EWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EWE>(arg0, 9, b"EWE", b"AWEWE", b"Ewe is a memecoin from UTC+7 people badword, and awewe meaning is girl . Don't try to figure out what it means because it's just a meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3c1330c-085c-4409-ae14-378b082a1771.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

