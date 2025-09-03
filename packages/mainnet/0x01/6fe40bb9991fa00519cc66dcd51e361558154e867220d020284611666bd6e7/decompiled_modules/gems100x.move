module 0x16fe40bb9991fa00519cc66dcd51e361558154e867220d020284611666bd6e7::gems100x {
    struct GEMS100X has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMS100X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMS100X>(arg0, 9, b"GEMS100X", b"DON'T RUG 100X GEMS", b"100X MULTIPLY YOUR SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GEMS100X>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMS100X>>(v2, @0xd6c83825bb4ee6c9eeb91706061c42b4eb425ae54c98e94ef9f8b37cb07b83ac);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEMS100X>>(v1);
    }

    // decompiled from Move bytecode v6
}

