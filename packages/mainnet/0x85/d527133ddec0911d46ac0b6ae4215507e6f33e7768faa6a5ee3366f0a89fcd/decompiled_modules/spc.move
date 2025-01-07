module 0x85d527133ddec0911d46ac0b6ae4215507e6f33e7768faa6a5ee3366f0a89fcd::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPC>(arg0, 9, b"SPC", b"SeaSpongeCoin", b"GEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/imgres?q=Sea%20Sponge%20animated&imgurl=https%3A%2F%2Fpics.craiyon.com%2F2023-11-17%2FvXGbc-f7SxqGpHeYzK_BKA.webp&imgrefurl=https%3A%2F%2Fwww.craiyon.com%2Fimage%2FtoF48O9QSvaDygjgFM3JGA&docid=2yTmANSMi0Jj6M&tbnid=9AHdg6pVcWLztM&vet=12ahUKEwj79oXvh6eGAxXWuZUCHfR7ARoQM3oECEYQAA..i&w=1024&h=1024&hcb=2&ved=2ahUKEwj79oXvh6eGAxXWuZUCHfR7ARoQM3oECEYQAA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

