module 0xe5b456d229e8af7fb8e121dc37cb2cacb61788bdbd25998414c59ce425f12538::osai {
    struct OSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAI>(arg0, 6, b"OSAI", b"OSAI AGENTS", b"OSAI AGENTS is here to bring us to the mooooooon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RRRZ_9h_Sjn_Zob_W_Cng_LS_Pq_Exisfojo_Jr_PBQKQ_1ybb7_Ejwh_1_1_3e4d2bcd2b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

