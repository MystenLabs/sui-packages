module 0xcae8e140603a6d85e55967b39a7327e23ba4e8a7e9d7d431e1fbab7322949c9d::plankz {
    struct PLANKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANKZ>(arg0, 6, b"PLANKZ", b"Plankz On Sui", b"just the main character", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Plankz_Text_Mobile_d9c85df4b4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

