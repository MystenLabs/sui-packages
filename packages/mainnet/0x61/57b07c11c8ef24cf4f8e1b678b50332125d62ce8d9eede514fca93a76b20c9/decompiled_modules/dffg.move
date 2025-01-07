module 0x6157b07c11c8ef24cf4f8e1b678b50332125d62ce8d9eede514fca93a76b20c9::dffg {
    struct DFFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFFG>(arg0, 9, b"dffg", b"tttes", b"asdase", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DFFG>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFFG>>(v2, @0x1dd288499087064cfb0cbd426e5bde202a22493d67a1c130c10040197cc5bd51);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

