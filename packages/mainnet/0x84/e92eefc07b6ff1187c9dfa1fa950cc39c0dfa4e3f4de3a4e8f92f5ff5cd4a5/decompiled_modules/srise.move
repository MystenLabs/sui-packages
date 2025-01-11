module 0x84e92eefc07b6ff1187c9dfa1fa950cc39c0dfa4e3f4de3a4e8f92f5ff5cd4a5::srise {
    struct SRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRISE>(arg0, 6, b"SRISE", b"SUIRISE", b"Community driven movement that believes in the rise of Sui network. We create, inspire, and lead the charge toward a future powered by Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logocircle_322a0e47fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

