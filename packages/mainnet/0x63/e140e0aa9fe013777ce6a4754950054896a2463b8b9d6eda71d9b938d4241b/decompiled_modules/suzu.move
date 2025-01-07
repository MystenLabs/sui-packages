module 0x63e140e0aa9fe013777ce6a4754950054896a2463b8b9d6eda71d9b938d4241b::suzu {
    struct SUZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUZU>(arg0, 6, b"SUZU", b"Suzuctosui", b"The siba dog of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000243_55e79fb6e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

