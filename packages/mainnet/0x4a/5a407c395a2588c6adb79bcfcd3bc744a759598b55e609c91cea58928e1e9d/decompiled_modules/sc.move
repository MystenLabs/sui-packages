module 0x4a5a407c395a2588c6adb79bcfcd3bc744a759598b55e609c91cea58928e1e9d::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SC>(arg0, 6, b"SC", b"Sonic coming", b"It's sonic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/892606e2-9263-4f1a-aa7e-0fa65c1e0089.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SC>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SC>>(v1);
    }

    // decompiled from Move bytecode v6
}

