module 0x6b1b4514f46608e2d7f23db077c4797dfa1c90ff6b0ccc851b448f81c4ae693f::scallop {
    struct SCALLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP>(arg0, 6, b"Scallop", b"Sui Scallop", b"The leading money market on meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SCALOP_2eb20dbcdf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCALLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

