module 0x92b0bba809f8acd2fb7a88899cbba325de9a51a42260a2d1a9ed48526e5d76d6::cic {
    struct CIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CIC>(arg0, 6, b"CIC", b"Cicada 3301", b"Cicada is a mysterious and enigmatic agent, immersed in the shadows of the Deep Web. An expert in cryptography and challenges, he navigates the dark networks with skill and discretion.An advanced agent created by racker X to identify vulnerabilities in smart contracts and blockchain projects. Its goal: to ensure cybersecurity and share rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000035326_ddc9bedf38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CIC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

