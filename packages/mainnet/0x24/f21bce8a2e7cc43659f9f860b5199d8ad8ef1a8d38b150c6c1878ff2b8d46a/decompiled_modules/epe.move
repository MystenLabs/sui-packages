module 0x24f21bce8a2e7cc43659f9f860b5199d8ad8ef1a8d38b150c6c1878ff2b8d46a::epe {
    struct EPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPE>(arg0, 6, b"EPE", b"APA", b"APEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/9d170289-f5e3-4a7c-b504-a1e132a72fef.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EPE>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

