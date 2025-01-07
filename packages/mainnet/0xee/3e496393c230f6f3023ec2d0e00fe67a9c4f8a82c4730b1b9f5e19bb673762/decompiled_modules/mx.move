module 0xee3e496393c230f6f3023ec2d0e00fe67a9c4f8a82c4730b1b9f5e19bb673762::mx {
    struct MX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MX>(arg0, 6, b"MX", b"Mechazilla", b"The 1-million square foot Starfactory brings many parts of the manufacturing process under one roof for the first time, moving as much system integration work as possible earlier in the build process, with the goal of eventually producing 1,000 Ships a year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Or_D0ovmf_400x400_5ec7673350.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MX>>(v1);
    }

    // decompiled from Move bytecode v6
}

