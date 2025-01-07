module 0x98d8274f5c2a5edc45b28811dbd1c8a0951662d7b04dc9a736b9c5ef17d2120a::jenny {
    struct JENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENNY>(arg0, 9, b"JENNY", b"JENNY CHAN", b"To who loves cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7c050af-37da-4a8b-99f8-a10cb531f7cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

