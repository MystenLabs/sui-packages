module 0x6f0d8f33bbb4a3aee2a0c6b324e5cd158c3b691b5cb7514ea787c2f13b09647f::ricky {
    struct RICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKY>(arg0, 6, b"RICKY", b"RICKY THE PENGUIN", b"HEY ITS RICKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rikki_5445bfeb12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

