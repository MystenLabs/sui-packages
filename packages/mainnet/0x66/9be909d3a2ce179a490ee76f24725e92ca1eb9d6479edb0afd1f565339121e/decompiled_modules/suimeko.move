module 0x669be909d3a2ce179a490ee76f24725e92ca1eb9d6479edb0afd1f565339121e::suimeko {
    struct SUIMEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEKO>(arg0, 6, b"SUIMEKO", b"SuiMeko", b"Suimeko is a famous memecoin that was born in the sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241118_121118_06970a9973.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

