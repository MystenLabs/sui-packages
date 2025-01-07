module 0x9421732355130a2b47e1a442e6f87f7cdd1cd098890f4c3e9fa1d24d8fa1bd0e::dogma {
    struct DOGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGMA>(arg0, 6, b"DOGMA", b"DOGMA on SUI", x"496e2062656c6965662c2077652066696e6420707572706f73653b20696e206469736369706c696e652c2077652066696e6420706f7765720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_Qb_VW_9a_S_400x400_49b452b62a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

