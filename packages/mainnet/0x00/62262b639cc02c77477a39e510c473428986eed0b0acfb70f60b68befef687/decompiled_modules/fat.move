module 0x62262b639cc02c77477a39e510c473428986eed0b0acfb70f60b68befef687::fat {
    struct FAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAT>(arg0, 6, b"FAT", b"Frog Cat on Sui", b"A Cute Cat dressed as a Frog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/frogcat_bd8667a636.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

