module 0x8ceb68b926ee6bc6c6aceffe9e282f0831375cd5bc443b3c83666eee0782f9a2::suifu {
    struct SUIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFU>(arg0, 6, b"SUIFU", b"SuiFu", b"hiyahh!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jcy3_Tui_L_400x400_67d43b0eb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

