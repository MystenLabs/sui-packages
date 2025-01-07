module 0xcef2f08dba4be387157d073eeb88449a382aef22974a2005bbebb0f7d71f6ad6::scase {
    struct SCASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCASE>(arg0, 6, b"SCASE", b"SUITCASE", b"SUITTTTTTTTTCASEEEEEE, PICK YOUR SUITCASE AND LETS RIDE TO THE MOOOOOON!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_15_19ca252853.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

