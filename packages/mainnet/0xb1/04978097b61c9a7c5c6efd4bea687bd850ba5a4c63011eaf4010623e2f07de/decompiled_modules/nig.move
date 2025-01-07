module 0xb104978097b61c9a7c5c6efd4bea687bd850ba5a4c63011eaf4010623e2f07de::nig {
    struct NIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIG>(arg0, 6, b"NIG", b"Nigel", b"Hi, Im Nigel. Its time to reveal my face so you know who is making your next gem meme coin. Lets make crypto a safe community for all!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/neg_7593e9b451.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

