module 0xd32e4bc74265bab43e933fa756a7ef9ec0509b369c1f5e7bddf9f40ca53977cb::nos {
    struct NOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOS>(arg0, 6, b"NOS", b"Nos", b"Nitrous Oxide SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953181758.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

