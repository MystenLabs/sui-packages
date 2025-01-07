module 0x2ed2669670506f0080e0fa6e2fc89991ae51a81b9acc73b3b727ddc19062fc48::suipets {
    struct SUIPETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPETS>(arg0, 6, b"SUIPETS", b"Sui Pets", b"PetPals is place for friendship, education, and fun. Meet explorers from all over the world and build together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_8739165913.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

