module 0x28ed510675d90c9913d206fed21145f21eb1c823787343322b00dd01024cfc95::marlin {
    struct MARLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARLIN>(arg0, 6, b"Marlin", b"Marlin The Swordfish", b"I am a swordfish, living in the ocean of sui. Do you want to play with me?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_Xiphias_gladius_cartoon_89ea89998a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

