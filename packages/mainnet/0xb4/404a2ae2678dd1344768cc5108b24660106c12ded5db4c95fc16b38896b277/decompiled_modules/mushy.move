module 0xb4404a2ae2678dd1344768cc5108b24660106c12ded5db4c95fc16b38896b277::mushy {
    struct MUSHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSHY>(arg0, 6, b"MUSHY", b"Sui Mushy", x"4d75736879206973206a75737420612066756e6769206c6f6f6b696e6720666f7220736f6d652066756e676973206f6e207468656972205452495020746f20746865206d6f6f6e0a0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_18_10_42_59_b952b6b67c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

