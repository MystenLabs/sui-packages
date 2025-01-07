module 0x598b999d5cd6085f7a3e77cbba54e8f3c1897eeb9c6649359fbd874f9e230af4::pndl {
    struct PNDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNDL>(arg0, 6, b"PNDL", b"Pandalora the Gladiator", b"The true gladiator shows no mercy, but when it's a Pandalora, it brings engless smiles to everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Panda_Lora_716301b49a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNDL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNDL>>(v1);
    }

    // decompiled from Move bytecode v6
}

