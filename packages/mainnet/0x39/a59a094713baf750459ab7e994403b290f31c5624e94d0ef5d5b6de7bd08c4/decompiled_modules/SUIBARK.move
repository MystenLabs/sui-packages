module 0x39a59a094713baf750459ab7e994403b290f31c5624e94d0ef5d5b6de7bd08c4::SUIBARK {
    struct SUIBARK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBARK>, arg1: 0x2::coin::Coin<SUIBARK>) {
        0x2::coin::burn<SUIBARK>(arg0, arg1);
    }

    fun init(arg0: SUIBARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBARK>(arg0, 6, b"SuiBarK", b"@SUIBARK for the Sui Ecosystem", b"Twitter: @SUIBARK, Telegram: t.me/SUIBARK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1651074326282526726/9Gutqt1H_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBARK>>(v1);
        0x2::coin::mint_and_transfer<SUIBARK>(&mut v2, 250000000000000, 0x2::address::from_u256(64118830154537302403150903442187064611355386484903641353949656248553320336673), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBARK>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBARK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBARK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

