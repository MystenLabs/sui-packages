module 0xf08a6bb6c54d4552e8d33eb9203503a52a131feca4b7e4164a89227e1dd35ab9::tfc {
    struct TFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFC>(arg0, 6, b"TFC", b"Touch Fish Culture", b"Touching the fish is a symbol of luck and prosperity. Embrace this tradition and welcome good fortune.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2854_c6012bcb8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

