module 0xf2d1cbdc91091d7a8f09d6a18f74f463785c6bf38e26e5d7e933a2076985d2ee::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 9, b"SIU", b"SIU token on SUI", b"Token SIU on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/e459a00f-d7fb-4284-82fd-608a452a2028.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIU>(&mut v2, 500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

