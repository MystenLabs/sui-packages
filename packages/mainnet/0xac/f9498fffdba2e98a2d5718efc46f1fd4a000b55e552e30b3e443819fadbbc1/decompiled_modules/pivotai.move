module 0xacf9498fffdba2e98a2d5718efc46f1fd4a000b55e552e30b3e443819fadbbc1::pivotai {
    struct PIVOTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIVOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIVOTAI>(arg0, 6, b"PivotAI", b"Crypto Pivot AI", x"5069766f742041493a20546865204d656d65636f696e2054686174277320536d6172746572205468616e20596f75205468696e6b205069766f7420414920697320746865207265766f6c7574696f6e617279206d656d65636f696e20746861742773206e6f74206a7573742061626f7574206c61756768732020697427732061626f7574206c657665726167696e672074686520706f776572206f6620414920746f206f7574736d61727420746865206d61726b65742e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ai_logo_cf4790703d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIVOTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIVOTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

