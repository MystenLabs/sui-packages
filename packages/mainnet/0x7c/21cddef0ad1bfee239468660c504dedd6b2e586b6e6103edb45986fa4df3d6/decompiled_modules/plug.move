module 0x7c21cddef0ad1bfee239468660c504dedd6b2e586b6e6103edb45986fa4df3d6::plug {
    struct PLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUG>(arg0, 6, b"PLUG", b"PLUG SUI", b"Time to PLUG up SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2505_9bd5fd47b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

