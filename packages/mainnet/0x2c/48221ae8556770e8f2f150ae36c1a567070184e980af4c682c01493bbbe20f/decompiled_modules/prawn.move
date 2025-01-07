module 0x2c48221ae8556770e8f2f150ae36c1a567070184e980af4c682c01493bbbe20f::prawn {
    struct PRAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRAWN>(arg0, 6, b"PRAWN", b"Prawn on Sui", b"The Original Pepe. Prawn on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Prawn_Logo_53755f3a17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

