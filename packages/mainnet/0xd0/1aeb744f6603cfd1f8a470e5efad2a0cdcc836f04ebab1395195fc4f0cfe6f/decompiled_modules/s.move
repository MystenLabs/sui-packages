module 0xd01aeb744f6603cfd1f8a470e5efad2a0cdcc836f04ebab1395195fc4f0cfe6f::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 8, b"S", b"Slaunch", b"s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/93e29452-078e-4ee7-9817-2c419e895266.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<S>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}

