module 0xb9e15217abd0a441b35769048862ca937beea81e81bf87be31ccb57a74164e5f::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"Puff Culture", b"THE INTERNET'S 4.20 CULTURE COIN. PUFF PUFF PASS. Originating from Stoned Ape Crew in 2021 and 2024. With a new look in 2025.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihu5hmlw2blo3nkzquny6q7m5kfl3tj3cffxtz5meolww7uvx2iay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

