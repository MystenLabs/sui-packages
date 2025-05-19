module 0x7753c70afa5cce3e681dfd946986d052acb00b3dfd44f22b04fb341c471614a3::kyo {
    struct KYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYO>(arg0, 6, b"KYO", b"Kyogre", b"Legendary Water-type with incredible stats and the ability Drizzle, which automatically summons rain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih6remvvtixo5bgxh66pulqevug45mcmusdckvmqd5vkpydwugodm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KYO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

