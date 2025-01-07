module 0x38609f5a3cf9e497d300181e63a4e8738661b298e17f30a1d63bd6041791add2::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 596 || 0x2::tx_context::epoch(arg1) == 597, 1);
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"you won www.fofo.com", b"you won www.vovo.com", b"this is the token description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreigtobosxyhf4dps3rbvwuhqkf54caijkg2pvphkawfg6x777bjptq.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 1000000000000000, @0x4e01ecfe6648af5abbfe4c6343c20faff36f2e8ee167a241dc51e14af1c2600e, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, @0x4e01ecfe6648af5abbfe4c6343c20faff36f2e8ee167a241dc51e14af1c2600e);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<TOKEN>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: &mut 0x2::coin::CoinMetadata<TOKEN>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<TOKEN>(arg0, arg1, arg2);
        0x2::coin::update_symbol<TOKEN>(arg0, arg1, arg3);
        0x2::coin::update_description<TOKEN>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<TOKEN>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

