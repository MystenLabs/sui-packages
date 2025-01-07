module 0x919b9ac65ce2d043e334bdfbdf9421f2ab9a21425eee8d173e043bebe3c62139::pfs {
    struct PFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFS>(arg0, 6, b"PFS", b"PEPE FISH on Sui", b"Just pepe as Fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gemini_Generated_Image_2om90j2om90j2om9_2c4fd0f669.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

