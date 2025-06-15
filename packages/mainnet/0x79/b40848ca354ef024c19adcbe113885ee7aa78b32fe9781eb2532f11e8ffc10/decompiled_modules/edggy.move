module 0x79b40848ca354ef024c19adcbe113885ee7aa78b32fe9781eb2532f11e8ffc10::edggy {
    struct EDGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDGGY>(arg0, 6, b"EDGGY", b"SUIDGY", b"Edggy is a smart, energetic mascot representing the face of community and tools within the Moonbags ecosystem on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia6krtuzosf3ipzsdzxaluog4t3xjrlpibjpftawz4jjl22move2m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EDGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

