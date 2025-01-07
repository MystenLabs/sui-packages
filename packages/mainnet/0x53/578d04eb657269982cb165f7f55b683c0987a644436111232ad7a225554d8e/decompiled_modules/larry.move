module 0x53578d04eb657269982cb165f7f55b683c0987a644436111232ad7a225554d8e::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"LARRY", b"Larry Sui Lobster", b"In Bikini Bottom, Larry the Lobster discovered cryptocurrency at Goo Lagoon. Inspired by SpongeBob and Patrick's talk about the Sui blockchain, he launched a fitness challenge, helping Sui thrive and proving even a lobster can make waves in crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731238020137.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LARRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

