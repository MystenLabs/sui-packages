module 0xc15ffd2986d143f1f8799941adef0dd00229001f9914dd4684a654e48347cfe4::ocat {
    struct OCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCAT>(arg0, 6, b"OCAT", b"Octocat", b"Octocat, GitHub's iconic half-cat, half-octopus mascot, is now entering the crypto space with a launch on the Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.ocat.fun/images/banner-main-img.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OCAT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

