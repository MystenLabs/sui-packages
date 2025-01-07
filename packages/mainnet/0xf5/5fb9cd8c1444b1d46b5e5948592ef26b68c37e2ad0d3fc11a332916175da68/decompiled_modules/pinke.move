module 0xf55fb9cd8c1444b1d46b5e5948592ef26b68c37e2ad0d3fc11a332916175da68::pinke {
    struct PINKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKE>(arg0, 6, b"PINKE", b"Pinke On Sui", b"Pinke - which are rich asf and full of joy n fun brrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008868_27c8115e90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

