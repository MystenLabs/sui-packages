module 0x3ffbd97f2229a921d20a610ef92e831b5f34691e2e27dd0a4d12ad4636c778bf::mummat {
    struct MUMMAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMMAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMMAT>(arg0, 6, b"MUMMAT", b"MUMMAT SUI", b"Mummat woke up in the dim light of some unknown pyramid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T7k_V_Wqn_Z_400x400_bc9625237c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMMAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMMAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

