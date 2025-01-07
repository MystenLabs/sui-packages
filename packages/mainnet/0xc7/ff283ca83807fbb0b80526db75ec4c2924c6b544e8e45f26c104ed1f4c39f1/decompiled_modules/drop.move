module 0xc7ff283ca83807fbb0b80526db75ec4c2924c6b544e8e45f26c104ed1f4c39f1::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROP>(arg0, 9, b"DROP", b"Bucket Drop Token", b"Participate in Bucket Protocol Simple Staking to earn drop token and $BUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aqua-natural-grasshopper-705.mypinata.cloud/ipfs/QmUC11CQt8jGhh5P4xd6NxqKgMNTEvZt2Jfkuu1J7WrRP8")), arg1);
        let (v2, v3) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::new<DROP>(v0, false, arg1);
        0x2::transfer::public_share_object<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<DROP>>(v2);
        0x2::transfer::public_transfer<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<DROP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DROP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

