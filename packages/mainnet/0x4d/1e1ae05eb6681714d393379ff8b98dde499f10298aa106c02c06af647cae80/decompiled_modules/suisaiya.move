module 0x4d1e1ae05eb6681714d393379ff8b98dde499f10298aa106c02c06af647cae80::suisaiya {
    struct SUISAIYA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISAIYA>, arg1: 0x2::coin::Coin<SUISAIYA>) {
        0x2::coin::burn<SUISAIYA>(arg0, arg1);
    }

    fun init(arg0: SUISAIYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAIYA>(arg0, 9, b"SuiSaiya", b"SUISAIYA", b"GRRRR...BURN To The Moon $SUISAIYA - Web https://suisaiyan.xyz/ - TG: https://t.me/SUISAIYAN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/0tZtY2r/AVA.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISAIYA>>(v1);
        0x2::coin::mint_and_transfer<SUISAIYA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAIYA>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISAIYA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISAIYA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

