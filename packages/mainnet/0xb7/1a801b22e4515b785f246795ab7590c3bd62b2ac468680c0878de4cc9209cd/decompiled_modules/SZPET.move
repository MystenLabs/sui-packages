module 0xb71a801b22e4515b785f246795ab7590c3bd62b2ac468680c0878de4cc9209cd::SZPET {
    struct SZPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZPET>(arg0, 9, b"SZPET", b"SUI zPet", b"SUI zPet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746758400594321408/bHUmmi04_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SZPET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZPET>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SZPET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SZPET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

