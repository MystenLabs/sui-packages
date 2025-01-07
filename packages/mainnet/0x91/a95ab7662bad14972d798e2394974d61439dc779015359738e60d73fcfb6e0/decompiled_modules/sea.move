module 0x91a95ab7662bad14972d798e2394974d61439dc779015359738e60d73fcfb6e0::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 6, b"SEA", b"SEA coin", b"SEA is a memecoin on SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732071278639.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

