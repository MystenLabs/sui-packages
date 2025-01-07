module 0xf4f4e8f7bd0e718b453488c6705ee7954ad7a4769b3b2e57b2e7d566d23dda51::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 6, b"PAC", b"HarryPotterTrumpElon24MagaPACMAN", b"HarryPotterTrumpElon24MagaPACMAN PAC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xea0b4dee5e451b0f5ea65feb4a768f4024a35b6e_338afb061a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

