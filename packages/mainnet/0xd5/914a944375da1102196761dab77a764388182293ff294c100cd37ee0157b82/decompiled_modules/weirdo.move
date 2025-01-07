module 0xd5914a944375da1102196761dab77a764388182293ff294c100cd37ee0157b82::weirdo {
    struct WEIRDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEIRDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEIRDO>(arg0, 9, b"Weirdo", b"Weirdo", b"HOLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x76734b57dfe834f102fb61e1ebf844adf8dd931e.png?size=xl&key=f5c984")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WEIRDO>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEIRDO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEIRDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

