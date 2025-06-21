module 0xe04b798168e33e72daf2b0b410b1eff614b87243174eece5bf94b7a9e7a9035d::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 8, b"S", b"The Superior Ticker", b"S on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/b3e658e1-2da6-460f-9610-4a34b2df8722.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<S>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}

