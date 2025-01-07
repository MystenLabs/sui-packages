module 0x7ead99905387313ca1d20529bcf65668680a76bb3e33abd087db59696ada450c::hc_sofa {
    struct HC_SOFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HC_SOFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HC_SOFA>(arg0, 9, b"HC_Sofa", b"Habbo Club Sofa", b"Do not allow a corrupt foreign government to order you around!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fb85079b92d7e748ceb695d4ba85ef82blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HC_SOFA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HC_SOFA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

