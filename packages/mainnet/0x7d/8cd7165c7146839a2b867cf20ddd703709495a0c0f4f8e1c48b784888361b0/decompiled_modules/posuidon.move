module 0x7d8cd7165c7146839a2b867cf20ddd703709495a0c0f4f8e1c48b784888361b0::posuidon {
    struct POSUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSUIDON>(arg0, 6, b"POSUIDON", b"posuidon", b"The God Of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0013_b65d59f024.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSUIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSUIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

