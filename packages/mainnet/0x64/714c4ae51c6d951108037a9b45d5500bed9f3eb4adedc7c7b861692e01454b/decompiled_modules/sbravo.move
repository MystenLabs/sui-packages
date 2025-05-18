module 0x64714c4ae51c6d951108037a9b45d5500bed9f3eb4adedc7c7b861692e01454b::sbravo {
    struct SBRAVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRAVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBRAVO>(arg0, 6, b"SBRAVO", b"Sui Bravo", b"The most handsome and muscular of the SUI network, I'm here baby, I'm going to set a new trend ouhhh Yeahhh!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidcg5yzqctne6apz6oktnudgofqshz4dvaa7whqhi3z5ynuit7dju")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRAVO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBRAVO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

