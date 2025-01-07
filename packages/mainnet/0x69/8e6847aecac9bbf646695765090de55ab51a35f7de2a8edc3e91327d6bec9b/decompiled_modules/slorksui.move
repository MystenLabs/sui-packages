module 0x698e6847aecac9bbf646695765090de55ab51a35f7de2a8edc3e91327d6bec9b::slorksui {
    struct SLORKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLORKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLORKSUI>(arg0, 6, b"SLORKSUI", b"SLOORK", b"$Slork the sleppy sloth on #Sui coming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lmx_D8m30_400x400_8878d2082a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLORKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLORKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

