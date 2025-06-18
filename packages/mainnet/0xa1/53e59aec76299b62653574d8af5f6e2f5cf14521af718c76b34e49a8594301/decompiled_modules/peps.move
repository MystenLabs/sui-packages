module 0xa153e59aec76299b62653574d8af5f6e2f5cf14521af718c76b34e49a8594301::peps {
    struct PEPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPS>(arg0, 6, b"PEPS", b"PEPS Singer", b"New Peps singer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5062_80a329250e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

