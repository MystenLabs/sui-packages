module 0x304350bdb3d21b682f5acce2962db3a9926026afaab7edeb9f3ea4d225af9587::kdad {
    struct KDAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: KDAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDAD>(arg0, 6, b"KDAD", b"SUI KIWIDAD", x"4f6e6c792061206d656d65636f696e20666f72206b69776920646164732e204e6f7468696e67206d6f72652c206e6f7468696e67206c6573732e200a0a4b69776964616420636f6d6d756e697479206d6f76656d656e742e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_20240924_220925_401_aaeaf5666d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KDAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KDAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

