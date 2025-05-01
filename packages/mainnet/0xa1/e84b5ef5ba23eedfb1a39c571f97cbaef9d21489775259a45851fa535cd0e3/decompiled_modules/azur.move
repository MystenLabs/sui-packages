module 0xa1e84b5ef5ba23eedfb1a39c571f97cbaef9d21489775259a45851fa535cd0e3::azur {
    struct AZUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZUR>(arg0, 6, b"Azur", b"AzurCryptus", b"From the depths of the SUI, Azur Cryptus risesa force of chaos and opportunity. A memetic power, a decentralized legend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1735443140053_bc19fb8ba6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

