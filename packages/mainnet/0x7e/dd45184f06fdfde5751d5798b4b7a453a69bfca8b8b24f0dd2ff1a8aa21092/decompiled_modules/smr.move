module 0x7edd45184f06fdfde5751d5798b4b7a453a69bfca8b8b24f0dd2ff1a8aa21092::smr {
    struct SMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMR>(arg0, 6, b"SMR", b"SUIMURFS", b"No Taxes, No Bullshit. It's just suimurfs on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019822_c76f7cb2e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMR>>(v1);
    }

    // decompiled from Move bytecode v6
}

