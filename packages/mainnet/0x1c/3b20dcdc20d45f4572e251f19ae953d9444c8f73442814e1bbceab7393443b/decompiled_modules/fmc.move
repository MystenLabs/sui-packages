module 0x1c3b20dcdc20d45f4572e251f19ae953d9444c8f73442814e1bbceab7393443b::fmc {
    struct FMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMC>(arg0, 6, b"FMC", b"Fumiko The Coral", b"Who said corals dont have emotions?!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6085_8b68061ae7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

