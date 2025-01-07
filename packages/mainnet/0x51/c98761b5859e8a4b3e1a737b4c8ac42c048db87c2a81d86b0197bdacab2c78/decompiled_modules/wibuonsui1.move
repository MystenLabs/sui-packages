module 0x51c98761b5859e8a4b3e1a737b4c8ac42c048db87c2a81d86b0197bdacab2c78::wibuonsui1 {
    struct WIBUONSUI1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIBUONSUI1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIBUONSUI1>(arg0, 9, b"WIBUONSUI1", b"WBOS", b"The first wibu on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f61dc9e1-2966-4e37-aa3a-db136d4609a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIBUONSUI1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIBUONSUI1>>(v1);
    }

    // decompiled from Move bytecode v6
}

