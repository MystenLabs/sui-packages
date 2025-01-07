module 0x9bdcf30658ef1d85f8206f3f1174a43309f4ed17d304bd3b71bdf52c1208b460::grn {
    struct GRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRN>(arg0, 6, b"GRN", b"grinn", b"kristtt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cp_D_Ii_Dm2_400x400_3fe876cf39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

