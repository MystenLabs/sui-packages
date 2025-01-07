module 0x6bcc4cb7991aa4f7b08ab0bcfb007a9431f70c4bbe95612610317e5cec05f0a2::SUIPOTS {
    struct SUIPOTS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPOTS>, arg1: 0x2::coin::Coin<SUIPOTS>) {
        0x2::coin::burn<SUIPOTS>(arg0, arg1);
    }

    fun init(arg0: SUIPOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOTS>(arg0, 6, b"SuiPots", b"@SuiPotsNFT", b"Twitter: @SuiPotsNFT, Telegram: t.me/SUIPOTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1651074326282526726/9Gutqt1H_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPOTS>>(v1);
        0x2::coin::mint_and_transfer<SUIPOTS>(&mut v2, 250000000000000, 0x2::address::from_u256(83335382405699088050379356576619177646275722123234323451583229599570886520077), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOTS>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPOTS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPOTS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

