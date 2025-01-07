module 0xf8933b8623bc8d7dbb12acd9168354d9b058bb63d0e1286d969baab82d508791::aaaw {
    struct AAAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAW>(arg0, 6, b"AAAW", b"AAA Walter", b"AAA Walter is a chad on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_06_T162457_783_994feee7a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

