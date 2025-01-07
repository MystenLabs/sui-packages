module 0x5abd2271c851bdb5a7e0866f1dcfdcf7a636973cce72162cc0e752439cdf5bf::psui {
    struct PSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUI>(arg0, 6, b"PSUI", b"PunksSUI", b"Free from adulteration or alterations, allowing you to live the pure essence of this nfts revolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Punks_SUI_1000_9a745d372b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

