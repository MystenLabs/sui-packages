module 0x20572e3eb727cc028bd17c74f727087c1fe776c68cf0bacebcc47f87941fd1d3::spup {
    struct SPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUP>(arg0, 6, b"SPUP", b"Seal Pup", b"The cutest seal pup in the SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_102310_741b57d6c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

