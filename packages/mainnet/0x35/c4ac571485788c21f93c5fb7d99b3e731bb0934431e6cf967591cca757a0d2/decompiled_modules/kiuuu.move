module 0x35c4ac571485788c21f93c5fb7d99b3e731bb0934431e6cf967591cca757a0d2::kiuuu {
    struct KIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIUUU>(arg0, 6, b"KIUUU", b"KIUUUUUUUUUUUUUU", b"Ribbit croak, chirp chirp ribbit, deep croak grrrrk ribbit!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/87_487b0436d5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

