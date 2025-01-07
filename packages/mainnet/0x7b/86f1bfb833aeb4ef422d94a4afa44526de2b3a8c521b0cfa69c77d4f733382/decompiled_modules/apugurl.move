module 0x7b86f1bfb833aeb4ef422d94a4afa44526de2b3a8c521b0cfa69c77d4f733382::apugurl {
    struct APUGURL has drop {
        dummy_field: bool,
    }

    fun init(arg0: APUGURL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APUGURL>(arg0, 6, b"ApuGurl", b"Apu Gurl", b"Apu Gurl is an anthropomorphic female frog character that is a customizable variant of Pepe the Frog and drawn in the style of Apu Apustaja ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_ASDASDWE_Wtulo_1_060ff00d25.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APUGURL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APUGURL>>(v1);
    }

    // decompiled from Move bytecode v6
}

