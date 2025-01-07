module 0xeb6d012aeb35e7d70c101842cf57d5356d7f423b4494d45ac70fb4677a605604::hahah {
    struct HAHAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHAH>(arg0, 9, b"HAHAH", b"Shanid", b"My own", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2049355-9e46-4cc9-9439-bf6b9cfcee7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

