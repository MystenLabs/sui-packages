module 0x971087b674d8f0c882f952c7bf43cc6a6c598499ca2c59118f859d383fe886ac::pndl {
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

