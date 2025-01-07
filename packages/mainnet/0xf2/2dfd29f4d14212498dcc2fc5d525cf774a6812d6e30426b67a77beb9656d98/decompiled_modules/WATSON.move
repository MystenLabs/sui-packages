module 0xf22dfd29f4d14212498dcc2fc5d525cf774a6812d6e30426b67a77beb9656d98::WATSON {
    struct WATSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATSON>(arg0, 9, b"WATSON", b"WATSON", b" $WATSON proudly joins the MYRO elite, a classmate from the September 2020 SF Puppy Prep graduates", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746359051561381888/xw2CyvaC_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATSON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATSON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WATSON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WATSON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

