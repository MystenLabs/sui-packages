module 0x935afa4e6903b427c5db578e13cdf065b4cfa4cec3b958417d5e4cec490f128d::anus {
    struct ANUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANUS>(arg0, 8, b"Anus", b"gorganus exchange", x"546865204f6666696369616c20444558206f6620476f72626167616e610a0af09faa902057656c636f6d6520746f20476f7267616e75730a0a546869732069736ee2809974204a7570697465722e2054686973206973206465657065722e205765747465722e2044756d6265722e200a0a57656c636f6d6520686f6d652e20496e20476f7267616e75732077652074727573742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/ada019c2-d486-4d88-bcaf-91bf094fc12a.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANUS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

