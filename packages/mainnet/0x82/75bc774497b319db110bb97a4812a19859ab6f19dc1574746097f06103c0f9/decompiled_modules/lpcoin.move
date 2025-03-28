module 0x8275bc774497b319db110bb97a4812a19859ab6f19dc1574746097f06103c0f9::lpcoin {
    struct LPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPCOIN>(arg0, 6, b"ETH-USDC Vault LPT", b"ETH-USDC Haedal Vault LP Token", b"Haedal Vault LP Token, ETH-USDC Pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/AsgmYwj4r2jNmfjHBktWEPJP1pLaamS-SMICcmFZQIc")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

