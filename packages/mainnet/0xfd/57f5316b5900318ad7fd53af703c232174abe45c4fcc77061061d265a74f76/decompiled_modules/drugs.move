module 0xfd57f5316b5900318ad7fd53af703c232174abe45c4fcc77061061d265a74f76::drugs {
    struct DRUGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRUGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRUGS>(arg0, 6, b"DRUGS", b"Only Drugs", b"The real drugs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_11_T095855_146_e2b578186d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRUGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRUGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

