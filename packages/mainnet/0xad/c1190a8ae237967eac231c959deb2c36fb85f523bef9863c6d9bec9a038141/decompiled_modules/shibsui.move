module 0xadc1190a8ae237967eac231c959deb2c36fb85f523bef9863c6d9bec9a038141::shibsui {
    struct SHIBSUI has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SHIBSUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHIBSUI>>(arg0, arg1);
    }

    fun init(arg0: SHIBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBSUI>(arg0, 4, b"SHUI", b"ShibSui", b"first memecoin on SUI ecosystems, built to community and driven by community. https://t.me/shibsui_ann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/dpywRfT.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SHIBSUI>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBSUI>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBSUI>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIBSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHIBSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

