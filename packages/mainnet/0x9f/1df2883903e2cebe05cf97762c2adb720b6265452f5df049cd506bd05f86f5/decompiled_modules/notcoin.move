module 0x9f1df2883903e2cebe05cf97762c2adb720b6265452f5df049cd506bd05f86f5::notcoin {
    struct NOTCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NOTCOIN>, arg1: 0x2::coin::Coin<NOTCOIN>) {
        0x2::coin::burn<NOTCOIN>(arg0, arg1);
    }

    fun init(arg0: NOTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTCOIN>(arg0, 9, b"Number One Trumpus", b"NOT", b"Something big is coming soon. But it's probably nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://numberonetrump.online/wp-content/uploads/2024/05/trumpcoin-removebg-preview.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOTCOIN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NOTCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NOTCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

