module 0xa650fa19dddfb4ca41f8e751c78c710b6ae1edcb4fdfc99bcb46222ae98c7930::fmc {
    struct FMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMC>(arg0, 6, b"FMC", b"Fumiko The Coral", b"Who said corals don't have emotions?!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6085_8b68061ae7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

