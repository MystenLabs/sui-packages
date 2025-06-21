module 0xa8f7add2f186e659652e432266bae0dbd4136ea2c0bb54ceccecd62d7790c6b2::hain {
    struct HAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIN>(arg0, 6, b"HAIN", b"Humanized AI Network", b"Humanized AI Network is revolutionizing the way humans interact with AI by combining cutting-edge artificial intelligence with blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/9c87b3b5-03da-4251-8e9f-6591cb0fbe61.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAIN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

