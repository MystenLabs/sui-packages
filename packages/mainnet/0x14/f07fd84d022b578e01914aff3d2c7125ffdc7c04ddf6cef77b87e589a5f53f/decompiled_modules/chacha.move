module 0x14f07fd84d022b578e01914aff3d2c7125ffdc7c04ddf6cef77b87e589a5f53f::chacha {
    struct CHACHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHACHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHACHA>(arg0, 9, b"CHACHA", b"Chachamaru", b"Chachamaru the Shiba Inu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid7foodhdl34ifexfiruyvfodwcveuq4hqy356h6qp7wjv45uj3ci")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHACHA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHACHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHACHA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

