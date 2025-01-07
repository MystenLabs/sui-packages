module 0x80b2fb0c49b967f3d452f31b043f8605dfc20f3cc0054afc57ccd67575d4656b::mobsui {
    struct MOBSUI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOBSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOBSUI>>(0x2::coin::mint<MOBSUI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBSUI>(arg0, 6, b"MOBSUI", b"MobSuiOFC", b"The Greatest Whale of all time is coming to the Ocean of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fphoto_2024_10_17_06_03_26_c1a3c993e8.jpg&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOBSUI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOBSUI>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

