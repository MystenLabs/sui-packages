module 0x53a7705216f1c9e2c9970cc0e07bdd0abd30ec476e9563bb4c07b23ae98097ef::quacoc {
    struct QUACOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACOC>(arg0, 6, b"QUACOC", b"Quack Cocaine", x"517561636b20697320686967682061732061206b697465206f6e20434f4341494e4521212120464c5920484947482041532041204455434b204f4e205448452053554920434841494e20574954482055532121212121204e554d4220594f555220464143452121210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MAINLOGOQUACK_b84121baab_7f48894eb5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

