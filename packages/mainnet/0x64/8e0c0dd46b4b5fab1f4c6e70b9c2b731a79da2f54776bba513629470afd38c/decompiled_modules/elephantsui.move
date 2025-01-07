module 0x648e0c0dd46b4b5fab1f4c6e70b9c2b731a79da2f54776bba513629470afd38c::elephantsui {
    struct ELEPHANTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEPHANTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEPHANTSUI>(arg0, 6, b"Elephantsui", b"Elephant on sui", b"Wave of sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000904314_a5a32f2725.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEPHANTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEPHANTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

