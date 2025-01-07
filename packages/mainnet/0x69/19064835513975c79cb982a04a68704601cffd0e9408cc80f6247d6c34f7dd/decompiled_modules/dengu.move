module 0x6919064835513975c79cb982a04a68704601cffd0e9408cc80f6247d6c34f7dd::dengu {
    struct DENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENGU>(arg0, 6, b"DENGU", b"SUI DENGU", b"What jeets dont know is that were going much higher. HOLDING STRONG ARMY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/deu1_643be6cd3a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

