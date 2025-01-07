module 0xa701fd62ec2da98578990ba4268a32622a64c2331d52e8853f90b8df97057aea::pufferfish {
    struct PUFFERFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFERFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFERFISH>(arg0, 6, b"Pufferfish", b"Sui Pufferfish", b"Small but fierce, Sui Pufferfish is ready to inflate and make waves on Sui. Watch out, this little guy packs a punch when you least expect it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pufferfish_f9c71e545a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFERFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFERFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

