module 0xa9c57632abc455f246ecbfc081cdc6825d735ac07fc1a6e4f39af48db440ea03::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 9, b"CHAD", b"CHAD", b"For Chads Only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.etsystatic.com/20023820/r/il/1b8ff5/4136743784/il_1080xN.4136743784_t2fc.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHAD>(&mut v2, 6900000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

