module 0x32d19ebc5db79671bc8062e615de50f26a223c4f37299a063b16a23aaabf2ba8::fff {
    struct FFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFF>(arg0, 6, b"FFF", b"Fight Fight Fight", b" Vote for Trump! Vote for a free America!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_135657_00f71af7bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

