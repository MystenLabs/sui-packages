module 0xcfd2bc58d96eb86bc48110e1cfdeebb5b9531317c2203cb415dfd44fab587cf0::lamb {
    struct LAMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMB>(arg0, 2, b"LAMB", b"LAMBALL", b"'HAH, you just got Lamballed!' Lamball ($LAMB): Your Pal on the SUI blockchain. This is an exciting fusion of PalWorld and crypto. Dive into our PalWorld server, engage in thrilling events and contests to earn $LAMB and other cool prizes. Connect with fellow Palworld enthusiasts and experience the best of both realms. $LAMB has something for everyone. Join us and discover the vibrant world of $LAMB on the SUI blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/UKynM3J.jpeg")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMB>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAMB>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAMB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LAMB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

