module 0x3c0d1101d9a60b605e34861eb5b28ab6867440125652d83f5ab1ad86136f80cc::hachi {
    struct HACHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHI>(arg0, 6, b"HACHI", b"HACHI ON SUI", b"The cats name is Hachi, Japanese for eight, inspired by the black markings on her forehead which look like the Chinese character for the number eight. The number eight is regarded as lucky in Japan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z_Hf_AZX_Az_400x400_8fa2dffb72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

