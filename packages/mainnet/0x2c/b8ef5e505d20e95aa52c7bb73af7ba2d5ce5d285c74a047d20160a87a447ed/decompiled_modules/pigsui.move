module 0x2cb8ef5e505d20e95aa52c7bb73af7ba2d5ce5d285c74a047d20160a87a447ed::pigsui {
    struct PIGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGSUI>(arg0, 6, b"Pigsui", b"Pigsui Man", b"Hero of Sui town", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jpegozan_b0b8653656.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

