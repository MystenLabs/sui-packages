module 0x246654aff1b211545fb8c9fe018c2ee0d510dfa9bac4ebfb6310db6bc2efbeb0::spootsui {
    struct SPOOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOTSUI>(arg0, 6, b"SPOOTSUI", b"Spootsui", x"53706f6f7473756920697320536f756e64204d6f6e65790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T170047_042_f001a7c8d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

