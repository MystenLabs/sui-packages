module 0x69d02f9fd1990b91dddccd3ea0bfc9c22610178363d35f9d368ea6c61a57950f::sjockey {
    struct SJOCKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJOCKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJOCKEY>(arg0, 6, b"Sjockey", b"Suiken Jockey", b"Chicken jockey?In Sui please call me Suiken Jockey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibtenqci5xfibgqzxvxppwauxkukmqxfsj5o2mky63qwwbnvqtqum")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJOCKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SJOCKEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

