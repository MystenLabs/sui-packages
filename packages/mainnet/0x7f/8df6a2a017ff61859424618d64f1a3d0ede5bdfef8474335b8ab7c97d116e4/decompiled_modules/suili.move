module 0x7f8df6a2a017ff61859424618d64f1a3d0ede5bdfef8474335b8ab7c97d116e4::suili {
    struct SUILI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILI>(arg0, 6, b"SUILI", b"SUILLI", b"THE CUTEST ANIMAL ON SUI, ON A MISSION TO BE WORTH SUILLYONS AND SUILLYONS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_184110031_c35924b14d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILI>>(v1);
    }

    // decompiled from Move bytecode v6
}

