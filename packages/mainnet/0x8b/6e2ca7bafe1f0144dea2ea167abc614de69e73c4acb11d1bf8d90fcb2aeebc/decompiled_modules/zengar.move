module 0x8b6e2ca7bafe1f0144dea2ea167abc614de69e73c4acb11d1bf8d90fcb2aeebc::zengar {
    struct ZENGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENGAR>(arg0, 6, b"ZENGAR", b"ZENGARR", b"Zengar is a ghostly memecoin summoned on the Sui blockchain. Inspired by Gengar, it brings mischief, speed, and shadow energy to the world of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibfnhvd2nqqmt4r523mt4ek7moya2bun7opvwpwuvncvnpnarmqi4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZENGAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

