module 0x4d02def992463e8381474591b3d61617071ac579f1b6a49e6a53ee4d0a57d20::frusty {
    struct FRUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUSTY>(arg0, 6, b"Frusty", b"Frusty Sui", b"Relaunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia5gauzy2ylsyqepoc4ob3jamlwlogznqa6bym6itrsts3svvy3bu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FRUSTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

