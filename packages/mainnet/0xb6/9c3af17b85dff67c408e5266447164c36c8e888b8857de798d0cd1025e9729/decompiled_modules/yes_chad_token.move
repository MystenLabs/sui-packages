module 0xb69c3af17b85dff67c408e5266447164c36c8e888b8857de798d0cd1025e9729::yes_chad_token {
    struct YES_CHAD_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YES_CHAD_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YES_CHAD_TOKEN>(arg0, 9, b"YES", b"Yes Chad", b"Yes - The Ultimate Multichain Asset", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://apricot-familiar-wasp-344.mypinata.cloud/ipfs/bafkreih3rcoznlgiuzxrt3mjq2tyzwnr2lzyietbhdo7ayu4qeps5kzsjy"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YES_CHAD_TOKEN>>(v1);
        0x2::coin::mint_and_transfer<YES_CHAD_TOKEN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YES_CHAD_TOKEN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

