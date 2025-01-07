module 0x76d904404acb2517f90d814fa4a1f646a9bb1fb63e0f2a85f9febe83fc9dc924::rett {
    struct RETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETT>(arg0, 6, b"RETT", b"Rett", b"Rett the ugliest mascot on SUI is here to take over the SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RETT_899e53471b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

