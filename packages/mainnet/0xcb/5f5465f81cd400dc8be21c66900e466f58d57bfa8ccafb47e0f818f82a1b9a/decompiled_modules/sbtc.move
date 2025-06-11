module 0xcb5f5465f81cd400dc8be21c66900e466f58d57bfa8ccafb47e0f818f82a1b9a::sbtc {
    struct SBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBTC>(arg0, 6, b"SBTC", b"SUIBTC", b"Welcome to the SUIBTC project - a project that will permanently join this community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidakdptd7di22mnihjcyrths5vcka47ballesljaxp6bp76qp7os4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

