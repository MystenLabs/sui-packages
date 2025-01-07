module 0x56a9ba8208500e211da184e9d8509631b38dc82404061fb14fcd4095b27bd962::anaconda {
    struct ANACONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANACONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANACONDA>(arg0, 6, b"ANACONDA", b"Sui Anaconda", b"Sui anaconda is the largest snake in the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JYgXbuR.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<ANACONDA>(&mut v2, 10000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANACONDA>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANACONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

