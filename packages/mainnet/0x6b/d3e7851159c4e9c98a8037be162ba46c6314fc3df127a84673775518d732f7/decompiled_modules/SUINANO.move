module 0x6bd3e7851159c4e9c98a8037be162ba46c6314fc3df127a84673775518d732f7::SUINANO {
    struct SUINANO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUINANO>, arg1: 0x2::coin::Coin<SUINANO>) {
        0x2::coin::burn<SUINANO>(arg0, arg1);
    }

    fun init(arg0: SUINANO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINANO>(arg0, 9, b"NANO", b"SUINANO", b"https://img.upanh.tv/2024/01/17/394076c3-5b50-4c45-82fd-e6481765b20b.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINANO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINANO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUINANO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUINANO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

