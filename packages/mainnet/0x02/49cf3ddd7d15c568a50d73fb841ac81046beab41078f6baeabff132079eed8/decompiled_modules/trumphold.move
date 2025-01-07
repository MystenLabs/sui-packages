module 0x249cf3ddd7d15c568a50d73fb841ac81046beab41078f6baeabff132079eed8::trumphold {
    struct TRUMPHOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPHOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPHOLD>(arg0, 6, b"TRUMPHOLD", b"TRUMPHOLDER", x"5472756d706f486f6c64657220c3a920612063726970746f6d6f6564612070617261207175656d20616372656469746120656d207365677572616ec3a7612c206573746162696c696461646520652076616c6f72697a61c3a7c3a36f2061206c6f6e676f207072617a6f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731899835059.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPHOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPHOLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

