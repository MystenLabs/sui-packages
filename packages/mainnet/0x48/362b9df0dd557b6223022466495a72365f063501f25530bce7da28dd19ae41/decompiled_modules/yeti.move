module 0x48362b9df0dd557b6223022466495a72365f063501f25530bce7da28dd19ae41::yeti {
    struct YETI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETI>(arg0, 6, b"YETI", b"YETI on Sui", b"Yeti is more than just a tokenit's a thrilling adventure through the icy peaks of the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tokenomics_9be664cc4d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YETI>>(v1);
    }

    // decompiled from Move bytecode v6
}

