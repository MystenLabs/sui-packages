module 0x5bdafd237c6ad88ff3ab8c4462ca73ea7d8fd7b9f2e9e52c4034bab48bbce311::revolt {
    struct REVOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REVOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REVOLT>(arg0, 6, b"Revolt", b"Revolution", b"When there's no hope, we got to revolt!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Trump_Patriot_2897484389_afa2c8ce39.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REVOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REVOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

