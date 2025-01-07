module 0x202096e7d2533aa44f934b5dee77a03a7bdd642c45a2f2a9ae0739d2446db5bb::suiwey {
    struct SUIWEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWEY>(arg0, 6, b"SUIWEY", b"SUBWEY ON SUI", b"My kind of fresh, just eat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/250x250_aae016673f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

