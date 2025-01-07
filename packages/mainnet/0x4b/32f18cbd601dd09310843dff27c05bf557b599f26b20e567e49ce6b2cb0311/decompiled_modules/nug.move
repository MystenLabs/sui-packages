module 0x4b32f18cbd601dd09310843dff27c05bf557b599f26b20e567e49ce6b2cb0311::nug {
    struct NUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUG>(arg0, 9, b"NUG", b"Nuggets", b"I'm a nugget", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/CjfqlOScovQAAAAd/roblox-nugget-roblox-man-face.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUG>>(v2, @0xe311e15b6e442f8a15e5769534037685de8b9560cdf09190791ce3bf680ac313);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

