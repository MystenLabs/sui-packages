module 0xfd39043886abe284988cf9a92b854d2c30ded8d1bafde18b4464b409d5ccffbd::tetaman {
    struct TETAMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETAMAN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 614 || 0x2::tx_context::epoch(arg1) == 615, 1);
        let (v0, v1) = 0x2::coin::create_currency<TETAMAN>(arg0, 9, b"MAN", b"Tetaman", b"The token is tetaman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreicw5qvnj67wahprenfowdiy464jhceficczjkutxyxojwe2atbkvi.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TETAMAN>(&mut v2, 1000000000000000, @0x635404724b56af9ddbf28bd8acd12b735b6465360810c438ef54a0152e418af8, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETAMAN>>(v2, @0x635404724b56af9ddbf28bd8acd12b735b6465360810c438ef54a0152e418af8);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TETAMAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<TETAMAN>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TETAMAN>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<TETAMAN>, arg1: &mut 0x2::coin::CoinMetadata<TETAMAN>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<TETAMAN>(arg0, arg1, arg2);
        0x2::coin::update_symbol<TETAMAN>(arg0, arg1, arg3);
        0x2::coin::update_description<TETAMAN>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<TETAMAN>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

