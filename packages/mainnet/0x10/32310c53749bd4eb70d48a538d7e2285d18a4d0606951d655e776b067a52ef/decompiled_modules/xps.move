module 0x1032310c53749bd4eb70d48a538d7e2285d18a4d0606951d655e776b067a52ef::xps {
    struct XPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPS>(arg0, 9, b"XPS", b"xryptos", b"Xryptos is a groundbreaking cryptocurrency designed to combat corruption and restore trust in the crypto industry. Built on a foundation of transparency, accountability, and security, Xryptos leverages advanced blockchain technology to ensure every transaction is traceable, fair, and tamper-proof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/af62cc95d8bd96e15469273b4d0ce94cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

