module 0x16a3929d22dab0764a347e55849bb005fb6a748123717561e8e4cb9f75c93e87::dpepe {
    struct DPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPEPE>(arg0, 9, b"DPEPE", b"DeepSeek Pepe", b"DeepSeek Pepe On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmc3BvcboeymfNxGuKkkSi8pAuq4E562h8FmgP74x6i22L")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DPEPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPEPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

