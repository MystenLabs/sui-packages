module 0x62faef6025fce2b5d06e0644d34b67fa0afa5c565dd4071b0f6e6b1c7c2545c8::innit {
    struct INNIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INNIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INNIT>(arg0, 6, b"INNIT", b"English Fish", b"IM A FISH, INNIT?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/british_fish_c7b1d77cb8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INNIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INNIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

