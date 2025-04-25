module 0x27c3b2575e05e34fe28b98a68520d333cb88725ab8ed5ed8b5a3a5de64e24fd9::rangersui {
    struct RANGERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RANGERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RANGERSUI>(arg0, 6, b"RANGERSUI", b"Power Ranger Sui", b" It's Morphin Time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_18_0a77332ec6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RANGERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RANGERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

