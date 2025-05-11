module 0xd62a97df807fd8f60d366ddd96f708544f7997c4f4aa21a765087ec63594a509::suikachu {
    struct SUIKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKACHU>(arg0, 6, b"SUIKACHU", b"Suikachu Pokemon", b"The new pokemon P2E on the SuiNetwork.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifuwq3qxahrpfv6rm7tqpgrytnxzivad2zxklby5esiludlhebn24")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKACHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

