module 0x66db949f7378c303be5bab63ae2fc3f80202634f4c61a9707a8977c73b8f76d6::psui {
    struct PSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUI>(arg0, 6, b"PSUI", b"SUI PORN", b"The one and only DICK of the SUI chain. Just let it happen it doesnt hurt!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Illustration_sans_titre_817fdf21e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

