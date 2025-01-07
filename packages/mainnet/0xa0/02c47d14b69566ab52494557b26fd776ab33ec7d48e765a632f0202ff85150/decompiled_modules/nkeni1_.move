module 0xa002c47d14b69566ab52494557b26fd776ab33ec7d48e765a632f0202ff85150::nkeni1_ {
    struct NKENI1_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKENI1_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKENI1_>(arg0, 9, b"NKENI1_", b"Phil ", x"4372656174696e67207765616c746820746f206d616b65206c6966652062657474657220666f72206d6520616e64206d79206c6f7665206f6e657320e29da3efb88ff09fa4a92e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f83760d4-b99e-4c7f-8f49-199f5955d2f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKENI1_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKENI1_>>(v1);
    }

    // decompiled from Move bytecode v6
}

