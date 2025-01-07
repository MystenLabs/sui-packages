module 0x5d6426010a27885fcdb316237113d807039e1118a2f26aebe8e85278901924de::sushithewonderforkeddog {
    struct SUSHITHEWONDERFORKEDDOG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUSHITHEWONDERFORKEDDOG>, arg1: 0x2::coin::Coin<SUSHITHEWONDERFORKEDDOG>) {
        0x2::coin::burn<SUSHITHEWONDERFORKEDDOG>(arg0, arg1);
    }

    fun init(arg0: SUSHITHEWONDERFORKEDDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSHITHEWONDERFORKEDDOG>(arg0, 9, b"sushi the wonder forked dog", b"sushi", b"sushi the dog, is the little brother of uni the original wonder dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiscan.xyz/static/media/suiCoinLogo.b3b77ca65ac4f170e7e075732ea93352.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSHITHEWONDERFORKEDDOG>>(v1);
        0x2::coin::mint_and_transfer<SUSHITHEWONDERFORKEDDOG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSHITHEWONDERFORKEDDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUSHITHEWONDERFORKEDDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUSHITHEWONDERFORKEDDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

