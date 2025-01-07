module 0x48b3adb9ac7ecc5f0bbd14814e0f59989b8f18703e18fabe8b269bb75718010e::astrosui {
    struct ASTROSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ASTROSUI>, arg1: 0x2::coin::Coin<ASTROSUI>) {
        0x2::coin::burn<ASTROSUI>(arg0, arg1);
    }

    fun init(arg0: ASTROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTROSUI>(arg0, 9, b"astrosui", b"asui", b"astrosui https://t.me/astrosui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiscan.xyz/static/media/suiCoinLogo.b3b77ca65ac4f170e7e075732ea93352.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASTROSUI>>(v1);
        0x2::coin::mint_and_transfer<ASTROSUI>(&mut v2, 69000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTROSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASTROSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ASTROSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

