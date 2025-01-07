module 0x52e187233fca638f474bdedcc4cfbbeb61c5ed68b57579356264ac3ad055f675::suian69 {
    struct SUIAN69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAN69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAN69>(arg0, 6, b"SUIAN69", b"Suiantel Core i69", b"69 M keke, Aos Ien ap I69-420000XXX CpeeFFFFu too 6,66Ghz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T160842_303_d0d972198f_a77ef3ed28.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAN69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAN69>>(v1);
    }

    // decompiled from Move bytecode v6
}

