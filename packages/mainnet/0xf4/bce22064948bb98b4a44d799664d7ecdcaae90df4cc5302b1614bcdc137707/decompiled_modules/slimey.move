module 0xf4bce22064948bb98b4a44d799664d7ecdcaae90df4cc5302b1614bcdc137707::slimey {
    struct SLIMEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIMEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIMEY>(arg0, 8, b"SLIMEY", x"476f72626167616e61e2809973204265737420667269656e64", x"476f72626167616e61e2809973204265737420667269656e64206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/db8168a8-4e9f-405c-8c69-533ae44cbe0c.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLIMEY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIMEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIMEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

