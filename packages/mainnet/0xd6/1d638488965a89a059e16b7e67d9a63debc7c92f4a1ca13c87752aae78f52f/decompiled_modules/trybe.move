module 0xd61d638488965a89a059e16b7e67d9a63debc7c92f4a1ca13c87752aae78f52f::trybe {
    struct TRYBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYBE>(arg0, 9, b"TRYBE", b"AlphaTrybe", b"Fuelled by Exclusive and Exceptional Style accommodating your significant taste is who you really are, the New Era.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/845101ff-1b4e-4be4-8fa8-4593ef6a714f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRYBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

