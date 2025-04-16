module 0x4729c8a3e26c810428cbb4fdd76344dcf02d26e7623733fa667bfd985380474c::suiisforeveryone {
    struct SUIISFOREVERYONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIISFOREVERYONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIISFOREVERYONE>(arg0, 6, b"Suiisforeveryone", b"Sui is for everyone", b"Sui is for everyone ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004312_5a74db287b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIISFOREVERYONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIISFOREVERYONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

