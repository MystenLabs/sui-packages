module 0x20876a534ec40b9a8a87107fd99658e33c843796e605ad5521c505a3a67a3846::bsbsb {
    struct BSBSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSBSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSBSB>(arg0, 6, b"Bsbsb", b"Hsbsb", b"Ghhb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig7ogbf7vjtvjqiqhozapwt2tdydj5xpiq3b2jeom4vbbkt6ojaf4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSBSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BSBSB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

