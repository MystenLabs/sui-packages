module 0xd5130bddc699a7148d6059a582fcbc9a07a045eaff0a1e4f26c6b11cf35cff2::slip {
    struct SLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIP>(arg0, 6, b"Slip", b"Sui Slip", b"Meme token SlipNFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SLIP_bcb7d35342.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

