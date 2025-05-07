module 0xcccf6f74439aa28e32f3e1542a4fc718108a7674038b120bf92620af36cc6225::swogs {
    struct SWOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOGS>(arg0, 6, b"SWOGS", b"SWOGSUI", b"SWO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih3y6wzq45tl2hrrl7eur5jwfd4vg5tayoq5nbc34kgfat3evw6ie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWOGS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

