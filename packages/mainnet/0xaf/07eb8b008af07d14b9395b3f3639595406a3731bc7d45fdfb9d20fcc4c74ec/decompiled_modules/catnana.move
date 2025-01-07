module 0xaf07eb8b008af07d14b9395b3f3639595406a3731bc7d45fdfb9d20fcc4c74ec::catnana {
    struct CATNANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATNANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATNANA>(arg0, 6, b"CATNANA", b"Sui Cat Nana", b"Do you like Nana? and catnana?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_15_T114301_240_3eab547a50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATNANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATNANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

