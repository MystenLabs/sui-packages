module 0xa3f6271948c59ca6c0dedc7ceebbe76b8f926c536d9cd3aae1d71d5c7b05589e::pipe {
    struct PIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPE>(arg0, 6, b"Pipe", b"Piper", b"Piper is a young friendly elephant lost on a Sui Blockchain help her home ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016622_3b0ab35a73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

