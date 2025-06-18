module 0x48feee39b5b4d75512764a2a91f805fc808a8591cea51bf718f394a9ac2edc8a::roll {
    struct ROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLL>(arg0, 6, b"ROLL", b"Rolldag", b"Rolldaging", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/bbff0901-22c9-45b2-b7ce-c29b2bb9dbb5.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROLL>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

