module 0x6cebd24f2d6a6fb24475fe189ea92f71d64a56bbfec8e0d443c20558e6a0f545::suipepedoge {
    struct SUIPEPEDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPEPEDOGE>, arg1: 0x2::coin::Coin<SUIPEPEDOGE>) {
        0x2::coin::burn<SUIPEPEDOGE>(arg0, arg1);
    }

    fun init(arg0: SUIPEPEDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1635196106933161985/mipKm73k_400x400.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<SUIPEPEDOGE>(arg0, 2, b"SUIPEPEDOGE", b"SPD", b"SuiPepeDoge to the moon!", v0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEPEDOGE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPEDOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPEPEDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPEPEDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

