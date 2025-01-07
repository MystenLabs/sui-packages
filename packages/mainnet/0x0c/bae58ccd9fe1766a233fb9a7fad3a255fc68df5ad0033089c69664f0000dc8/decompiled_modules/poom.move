module 0xcbae58ccd9fe1766a233fb9a7fad3a255fc68df5ad0033089c69664f0000dc8::poom {
    struct POOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOM>(arg0, 6, b"POOM", b"Poom On Sui", b"Pls pls pls let me kiss u $pOOM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048482_a129934025.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

