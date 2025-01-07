module 0xb6944e8cc2269a0ff0693432ae45a3c107a0b47ea54f0aea102e38ae5480d42d::suipig_token {
    struct SUIPIG_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPIG_TOKEN>, arg1: 0x2::coin::Coin<SUIPIG_TOKEN>) {
        0x2::coin::burn<SUIPIG_TOKEN>(arg0, arg1);
    }

    fun init(arg0: SUIPIG_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIG_TOKEN>(arg0, 9, b"SUIPIG", b"SUIPIG", b"SUIPIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeiazim7rkxkaklszfhysmxymyq44yxkimr3qyjvcpyqyrp5u755mpy.ipfs.w3s.link/photo_2023-05-04_17-17-13.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPIG_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIG_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPIG_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPIG_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

