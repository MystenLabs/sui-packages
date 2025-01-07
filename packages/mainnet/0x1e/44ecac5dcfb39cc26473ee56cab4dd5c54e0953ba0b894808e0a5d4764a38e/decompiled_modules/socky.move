module 0x1e44ecac5dcfb39cc26473ee56cab4dd5c54e0953ba0b894808e0a5d4764a38e::socky {
    struct SOCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKY>(arg0, 6, b"SOCKY", b"Socky", b"Meet Socky, the original character of meme sui, he is just an ordinary sock who brings enthusiasm and laughter to those who see him! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/iuz_QA_Qg_L_400x400_4ba33c509b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

