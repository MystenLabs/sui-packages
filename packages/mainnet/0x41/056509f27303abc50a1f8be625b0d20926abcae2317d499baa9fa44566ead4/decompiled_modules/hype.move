module 0x41056509f27303abc50a1f8be625b0d20926abcae2317d499baa9fa44566ead4::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 6, b"Hype", b"Hype Sui Mump", b"How You Please Everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2023_02_28_21_13_01_a12e783514.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

