module 0x6be99a94eca1c7a0d965ad01057307afc75f07e0674dadb6aed7633d0ab2cf8b::babydogwif {
    struct BABYDOGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYDOGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDOGWIF>(arg0, 6, b"BABYDOGWIF", b"Baby Dog Wif Hat", b"What is BABYDOGWIF? - A BABYDOG WIF A HAT = BABYDOGWIF?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x1x1_4a058e3f22.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYDOGWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYDOGWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

