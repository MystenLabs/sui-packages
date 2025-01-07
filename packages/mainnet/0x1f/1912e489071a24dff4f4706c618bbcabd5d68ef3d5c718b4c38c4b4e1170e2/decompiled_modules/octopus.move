module 0x1f1912e489071a24dff4f4706c618bbcabd5d68ef3d5c718b4c38c4b4e1170e2::octopus {
    struct OCTOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPUS>(arg0, 6, b"OCTOPUS", b"OctopusFun Sui", b"Octopusfun a meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_155122_8f651a7740.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

