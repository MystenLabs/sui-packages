module 0xffbb7b87876e60c199bef06ed3c83b4e52f0cc1803aa751cd312beae39b76c81::xpump {
    struct XPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPUMP>(arg0, 6, b"XPUMP", b"XpumpFun", b"Not for the weak hearted", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibpxqnd5nf7zq63r5r6vh375jyhqma24ycb275r3haob3fpyaozry")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XPUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

