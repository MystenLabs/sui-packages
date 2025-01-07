module 0x20735bbe4412a6eabe42ece3804d05410515bd1deae660ac8d6bb5ad6264ef29::krab {
    struct KRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAB>(arg0, 9, b"KRAB", b"Krab Coin", b"Krab Meme on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844450738187202560/G5J9VHWM.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KRAB>(&mut v2, 446000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

