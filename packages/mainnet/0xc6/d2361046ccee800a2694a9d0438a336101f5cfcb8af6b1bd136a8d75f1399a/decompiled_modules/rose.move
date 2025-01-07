module 0xc6d2361046ccee800a2694a9d0438a336101f5cfcb8af6b1bd136a8d75f1399a::rose {
    struct ROSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSE>(arg0, 9, b"ROSE", b"Rose Token", b"Website:https://rosecoinonsui.xyz  - TG:https://t.me/LadyRose_Sui  - X: https://x.com/LadyRose_OnSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.rosecoinonsui.xyz/images/1.1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROSE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

