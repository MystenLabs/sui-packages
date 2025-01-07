module 0xbb79c6f37643ce970dd8f5f046c49341c6f49aeea4838e6b9e55d7562dc6ecee::peker_token {
    struct PEKER_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEKER_TOKEN>, arg1: 0x2::coin::Coin<PEKER_TOKEN>) {
        0x2::coin::burn<PEKER_TOKEN>(arg0, arg1);
    }

    fun init(arg0: PEKER_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEKER_TOKEN>(arg0, 9, b"PEK", b"PEKER", b"PEKER token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1124634445481488385/0XQQLnjn_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEKER_TOKEN>>(v1);
        0x2::coin::mint_and_transfer<PEKER_TOKEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEKER_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEKER_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEKER_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

