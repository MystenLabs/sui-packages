module 0x4ea111fcfc555fbfcf65bf718216b2ccd10eb36149d2ab51ff61c9977911d76c::KITCAT {
    struct KITCAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KITCAT>, arg1: 0x2::coin::Coin<KITCAT>) {
        0x2::coin::burn<KITCAT>(arg0, arg1);
    }

    fun init(arg0: KITCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITCAT>(arg0, 9, b"KITCAT", b"KitCat", b"The Most Delicious Cat on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/WgTtGnb/KitCat.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KITCAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KITCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

