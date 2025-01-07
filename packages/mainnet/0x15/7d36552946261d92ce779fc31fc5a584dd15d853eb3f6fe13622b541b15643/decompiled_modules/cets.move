module 0x157d36552946261d92ce779fc31fc5a584dd15d853eb3f6fe13622b541b15643::cets {
    struct CETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETS>(arg0, 6, b"CETS", b"Battle Cets", b"Collect them all and dominate the cet pvp arena.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/COB_De_M_Ue_400x400_b6f9b077b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

