module 0x7c419bbe313de6a71915d1fce6df5d57e4caa71b285bc0c82a4a40823a93c3c1::surp {
    struct SURP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURP>(arg0, 6, b"Surp", b"Larp on SUI", b"Don't need socials just send it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4768_9128eb5914.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURP>>(v1);
    }

    // decompiled from Move bytecode v6
}

