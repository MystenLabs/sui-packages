module 0xaf52c70dfe4b254d110cc3b9d71afb98c38d9b375912062c5493f7d0d3ff75a4::flokisui {
    struct FLOKISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKISUI>(arg0, 6, b"FlokiSui", b"FLOKI SUI", b"Floki Sui is the official face of the Sui chain, bringing charisma and style to the blockchain world. Always ready for adventure, Floki Sui is here to guide you through the ever-evolving journey of the Sui ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_asdasd432423tulo_1_143ba6d004.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

