module 0xe08cdcb5eacdc0d8e385abf2fcf30a5c6ea4375812dc6243d08c0169b4b93ffc::disaster {
    struct DISASTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISASTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DISASTER>(arg0, 6, b"DISASTER", b"DISASTER GIRL", b"Zoe Roth, known as Disaster Girl, is the girl famous for her devilish smirk as a house burns in the background.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_201655_054_233102756d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DISASTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DISASTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

