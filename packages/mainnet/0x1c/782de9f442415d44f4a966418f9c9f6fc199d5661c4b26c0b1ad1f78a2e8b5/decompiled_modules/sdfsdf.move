module 0x1c782de9f442415d44f4a966418f9c9f6fc199d5661c4b26c0b1ad1f78a2e8b5::sdfsdf {
    struct SDFSDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFSDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFSDF>(arg0, 6, b"Sdfsdf", b"sg sdfsdf", b"DQD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ajouter_un_titre_13_d89c3156da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFSDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDFSDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

