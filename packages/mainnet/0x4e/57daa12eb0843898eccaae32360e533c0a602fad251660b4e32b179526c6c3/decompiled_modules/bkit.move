module 0x4e57daa12eb0843898eccaae32360e533c0a602fad251660b4e32b179526c6c3::bkit {
    struct BKIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKIT>(arg0, 6, b"BKIT", b"BigKittyDog", b"BigKittyDog | AI + Internet Culture + Integrity | Empeworing Community , Sparking Ideas, and helping Animals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019996_5ea3245791.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BKIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

