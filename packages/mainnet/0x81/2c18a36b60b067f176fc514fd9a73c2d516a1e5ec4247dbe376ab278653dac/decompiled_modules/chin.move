module 0x812c18a36b60b067f176fc514fd9a73c2d516a1e5ec4247dbe376ab278653dac::chin {
    struct CHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIN>(arg0, 6, b"CHIN", b"CHINSHURIN", b"A pearl that shakes the waves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giant_red_pearlscale_goldfish_grade_aa_69488412ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

