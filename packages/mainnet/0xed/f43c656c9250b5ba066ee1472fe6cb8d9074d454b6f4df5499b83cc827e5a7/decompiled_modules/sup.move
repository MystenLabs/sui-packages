module 0xedf43c656c9250b5ba066ee1472fe6cb8d9074d454b6f4df5499b83cc827e5a7::sup {
    struct SUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUP>(arg0, 9, b"SUP", b"SupX", b"SupXAirdrop community token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgdlvr.com/pic/photoresizer.com/20240927-4583/public")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUP>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUP>>(v2, @0x41616c679875857d991464c1c8002051e424244c1c9c080b9621ee3f3dc80a35);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

