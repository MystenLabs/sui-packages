module 0xcac46aa926503ed71bc3244d659c2f25189a74a8ff5c3e7cc2491763b9346e90::belly {
    struct BELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELLY>(arg0, 6, b"BELLY", b"BELLYSUI", x"42454c4c590a0a544f4b454e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z_S4uq2_Ap_400x400_4070cd2c10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

