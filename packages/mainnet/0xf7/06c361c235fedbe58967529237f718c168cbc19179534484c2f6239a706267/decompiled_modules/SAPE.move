module 0xf706c361c235fedbe58967529237f718c168cbc19179534484c2f6239a706267::SAPE {
    struct SAPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SAPE>, arg1: 0x2::coin::Coin<SAPE>) {
        0x2::coin::burn<SAPE>(arg0, arg1);
    }

    fun init(arg0: SAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPE>(arg0, 9, b"SAPE", b"SAPE", b"SAPE on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.crypto.com/token/icons/apecoin-ape/color_icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SAPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

