module 0xcca25e32c3a14aa98150478880432fdc3be1946e42178edeabd9afbb56591e2::ade {
    struct ADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADE>(arg0, 9, b"ADE", b"ADEIZA", b"ADEIZA TO THE MOON!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9984a460-5745-46cc-b9a2-d534bbe308ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

