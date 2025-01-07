module 0x6cd3a1b85b572952fc53fd405c8d5997cd03776f0e0e17f31b15809b6fe82d98::stl {
    struct STL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STL>(arg0, 9, b"STL", b"Stellar", b"Stellar revolutionizes the digital economy by enabling seamless transactions across borders. With lightning-fast speeds and low fees, it empowers businesses and individuals to embrace a decentralized future while ensuring security and transparency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8437be5-8b83-411a-890a-d00b9c40848c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STL>>(v1);
    }

    // decompiled from Move bytecode v6
}

