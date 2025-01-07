module 0x2676b2ec80b5acd470fa7175c180d1a2a0f03faeac4e5bf5e500d8065b9c5b30::smi {
    struct SMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMI>(arg0, 6, b"SMI", b"SUIMI", x"414e2041584f4c4f544c0a495320434f4d494e4720544f20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xb386e96b51e49860f0efd76bcf46b35c602ba76d1daebcdb97868d8b7cb5a49e_suimi_suimi_d7b667ad94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

