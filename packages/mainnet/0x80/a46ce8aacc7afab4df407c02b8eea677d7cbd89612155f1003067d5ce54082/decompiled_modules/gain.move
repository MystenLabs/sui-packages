module 0x80a46ce8aacc7afab4df407c02b8eea677d7cbd89612155f1003067d5ce54082::gain {
    struct GAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAIN>(arg0, 6, b"GAIN", b"Sui Gains", x"5375694761696e73206973206120636f6d6d756e69747920746f6b656e20666f7220616c6c207468652062726f73206f75742074686572652050756d70696e67206861726420696e207468652067796d20616c6c2064617920746972656c6573736c792e0a4a6f696e20616e64204761696e2077697468205375694761696e7321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_2455a3b310.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

