module 0xeac0802cee49f0a35e7a7ea78afe0e6712656b531ba0aa37179561ae0b0ad337::blkbrd {
    struct BLKBRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLKBRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLKBRD>(arg0, 6, b"BLKBRD", b"BlackBeard", b"@Blackbeard_OG5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w1vmb_ZO_400x400_a3b1fc1adf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLKBRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLKBRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

