module 0x3ee7357db34231393273108386c26a93a96ff765b42ce06a9ce7defd93ea7945::posuidon {
    struct POSUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSUIDON>(arg0, 6, b"POSUIDON", b"Posuidon", b"https://dexscreener.com/sui/0x207cf647dc4f99f6cb7bbd6066db2f5785eb709f30bdbbdba97d1d082b996371", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0013_f1969b8c8b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSUIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSUIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

