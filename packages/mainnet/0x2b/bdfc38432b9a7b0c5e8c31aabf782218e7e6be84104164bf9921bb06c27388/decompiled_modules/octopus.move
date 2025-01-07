module 0x2bbdfc38432b9a7b0c5e8c31aabf782218e7e6be84104164bf9921bb06c27388::octopus {
    struct OCTOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPUS>(arg0, 6, b"OCTOPUS", b"Sui octopus", b"This is a highly combat capable octopus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/el_O_Ha_K_Yt_400x400_2f0893cc3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

