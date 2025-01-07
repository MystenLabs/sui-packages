module 0xb5f8a83c250aa98c055ed7e13aa9a564ee73fcc9999c02055948b53e52b54c8::trumpdollars {
    struct TRUMPDOLLARS has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<TRUMPDOLLARS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<TRUMPDOLLARS>(arg0) + arg1 <= 10000000000000000, 2);
        0x2::coin::mint_and_transfer<TRUMPDOLLARS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TRUMPDOLLARS, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 598 || 0x2::tx_context::epoch(arg1) == 599, 1);
        let (v0, v1) = 0x2::coin::create_currency<TRUMPDOLLARS>(arg0, 9, b"TDOLLARS", b"TRUMPDOLLARS", b"Trump going to reign as new President. This coin is going through the roof with value and making instanmt millioanaires", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreicescd5uipw6xaurdpo6zw2inxwhr7nry3we257pwdeqckv4exs4m.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPDOLLARS>(&mut v2, 10000000000000000, @0xa998cbcfa6f063456c43249f2e045dc036f58fed85a4af88f15eab962840ca28, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPDOLLARS>>(v2, @0xa998cbcfa6f063456c43249f2e045dc036f58fed85a4af88f15eab962840ca28);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMPDOLLARS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<TRUMPDOLLARS>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPDOLLARS>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<TRUMPDOLLARS>, arg1: &mut 0x2::coin::CoinMetadata<TRUMPDOLLARS>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<TRUMPDOLLARS>(arg0, arg1, arg2);
        0x2::coin::update_symbol<TRUMPDOLLARS>(arg0, arg1, arg3);
        0x2::coin::update_description<TRUMPDOLLARS>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<TRUMPDOLLARS>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

