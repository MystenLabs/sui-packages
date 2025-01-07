module 0xccefa49a98cf270a007ffc195a2da16a93e548ab8708c1507fe51920deaecf6d::lori {
    struct LORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORI>(arg0, 6, b"Lori", b"Lorikeet", b"The rainbow lorikeet is a species of parrot found in Australia. It is common along the eastern seaboard, from northern Queensland to South Australia. Its habitat is rainforest, coastal bush and woodland areas. Six taxa traditionally listed as subspecies of the rainbow lorikeet are now treated as separate species. Now Sui will look after this lovey bird.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Australian_native_Rainbow_Lorikeet_f0363451c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

