module 0x9200f5c5ecaea4ef2f3c2b91d64414d451b77220c5c7da95a11d4e2350002f65::tungs {
    struct TUNGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNGS>(arg0, 6, b"TungS", b"Tung Tung Tung Sahur", x"e2809c54756e672054756e672054756e67205361687572e2809d206973206c61756e6368696e6720612067616d696e672061707020696e207468652063727970746f20776f726c642e204974206973206120706f70756c6172206d656d652074686174206f726967696e6174656420696e20496e646f6e6573696120616e64207370726561642061726f756e642074686520776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747378647233.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUNGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

