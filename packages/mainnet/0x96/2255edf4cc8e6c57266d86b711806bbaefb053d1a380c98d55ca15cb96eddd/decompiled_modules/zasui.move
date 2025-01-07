module 0x962255edf4cc8e6c57266d86b711806bbaefb053d1a380c98d55ca15cb96eddd::zasui {
    struct ZASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZASUI>(arg0, 6, b"ZAS", b"Zasui", b"Zasui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_N_D_N_D_d1b423d435.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

