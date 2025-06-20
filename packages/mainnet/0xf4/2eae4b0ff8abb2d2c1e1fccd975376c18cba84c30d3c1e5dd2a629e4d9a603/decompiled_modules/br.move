module 0xf42eae4b0ff8abb2d2c1e1fccd975376c18cba84c30d3c1e5dd2a629e4d9a603::br {
    struct BR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BR>(arg0, 6, b"BR", b"Bear", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/0edf390f-0880-46bc-a50b-2ccdfe0f32ed.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BR>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BR>>(v1);
    }

    // decompiled from Move bytecode v6
}

