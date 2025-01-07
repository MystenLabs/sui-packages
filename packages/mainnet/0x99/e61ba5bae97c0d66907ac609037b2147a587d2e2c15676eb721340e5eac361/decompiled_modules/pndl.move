module 0x99e61ba5bae97c0d66907ac609037b2147a587d2e2c15676eb721340e5eac361::pndl {
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

