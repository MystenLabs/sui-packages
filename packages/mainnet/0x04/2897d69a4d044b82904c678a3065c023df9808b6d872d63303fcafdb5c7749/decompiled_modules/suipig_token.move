module 0x42897d69a4d044b82904c678a3065c023df9808b6d872d63303fcafdb5c7749::suipig_token {
    struct SUIPIG_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPIG_TOKEN>, arg1: 0x2::coin::Coin<SUIPIG_TOKEN>) {
        0x2::coin::burn<SUIPIG_TOKEN>(arg0, arg1);
    }

    fun init(arg0: SUIPIG_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIG_TOKEN>(arg0, 9, b"SPIG", b"SPIG", b"SPIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeiazim7rkxkaklszfhysmxymyq44yxkimr3qyjvcpyqyrp5u755mpy.ipfs.w3s.link/photo_2023-05-04_17-17-13.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPIG_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIG_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPIG_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPIG_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

