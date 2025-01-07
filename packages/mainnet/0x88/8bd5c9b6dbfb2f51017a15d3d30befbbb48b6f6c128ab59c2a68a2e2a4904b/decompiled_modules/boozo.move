module 0x888bd5c9b6dbfb2f51017a15d3d30befbbb48b6f6c128ab59c2a68a2e2a4904b::boozo {
    struct BOOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOZO>(arg0, 6, b"Boozo", b"boozosui", b"Uniting boozo worldwide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x76734b57dfe834f102fb61e1ebf844adf8dd931e_ca7b5ff40d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

