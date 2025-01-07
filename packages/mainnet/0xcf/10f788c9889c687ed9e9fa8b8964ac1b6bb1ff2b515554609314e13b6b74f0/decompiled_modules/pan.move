module 0xcf10f788c9889c687ed9e9fa8b8964ac1b6bb1ff2b515554609314e13b6b74f0::pan {
    struct PAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAN>(arg0, 9, b"PAN", b"PAN", b"Pan or Propal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZPTTdkBdMJSYpkp6cGPeyMCoPFe4_UpYnCQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

