module 0xe473ab29f8da1f2e6660d6a7e64fd5740fb1788ddbbf5b4159c99942ba7c55cc::rizo {
    struct RIZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZO>(arg0, 6, b"Rizo", b"Rizo - Tesla's Mascot", b"Rizo - Tesla's Mascot ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xd2bd342a84321f488331a108eb0ebfa7db001504_be849fcf9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

