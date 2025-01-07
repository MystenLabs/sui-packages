module 0x9cf83d0bd66da06ab05612cbb4c381a2713a1440e28498d8a93614af6210523e::evd_token {
    struct EVD_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EVD_TOKEN>, arg1: 0x2::coin::Coin<EVD_TOKEN>) {
        0x2::coin::burn<EVD_TOKEN>(arg0, arg1);
    }

    fun init(arg0: EVD_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVD_TOKEN>(arg0, 9, b"EVD", b"evgeny-dev", b"evgeny-dev token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://th.bing.com/th/id/OIG.8KRetldJ0ptr..U6jdPD?pid=ImgGn")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVD_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVD_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EVD_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EVD_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

