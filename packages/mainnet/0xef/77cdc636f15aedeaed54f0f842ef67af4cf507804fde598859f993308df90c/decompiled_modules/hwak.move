module 0xef77cdc636f15aedeaed54f0f842ef67af4cf507804fde598859f993308df90c::hwak {
    struct HWAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWAK>(arg0, 6, b"HWAK", b"hwak art", b"Hawk empowers organizations. Build GenAI applications without worrying about prompt injections ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiepzwanl2reytpm7eykvh4wfcuqzcqtw7tlvf6j26m7acf4ob7qt4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HWAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

