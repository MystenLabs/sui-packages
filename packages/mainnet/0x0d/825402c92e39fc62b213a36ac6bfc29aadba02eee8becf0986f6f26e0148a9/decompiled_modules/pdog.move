module 0xd825402c92e39fc62b213a36ac6bfc29aadba02eee8becf0986f6f26e0148a9::pdog {
    struct PDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOG>(arg0, 9, b"PDOG", b"Pepe Doge", b"Welcome to $PDOGE.Website: https://pdogeonsui.fun - TG: https://t.me/Pdoge_Channel - X: https://x.com/PDoge_Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.pdogeonsui.fun/meme_avt.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PDOG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

