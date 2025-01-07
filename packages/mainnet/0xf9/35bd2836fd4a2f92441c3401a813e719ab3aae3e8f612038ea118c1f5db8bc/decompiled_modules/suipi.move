module 0xf935bd2836fd4a2f92441c3401a813e719ab3aae3e8f612038ea118c1f5db8bc::suipi {
    struct SUIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPI>(arg0, 6, b"SUIPI", b"SUIPINGUIN", x"24535549504920656d6261726b206f6e20616e2069637920616476656e74757265206c696b65206e6f206f746865722074616e647320617320612064697374696e6374697665206d656d6520746f6b656e206f6e205375692c20626f617374696e6720612063757465737420616e6420636861726d696e672070656e6775696e206d6173636f740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3541_14e4b8a3d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

