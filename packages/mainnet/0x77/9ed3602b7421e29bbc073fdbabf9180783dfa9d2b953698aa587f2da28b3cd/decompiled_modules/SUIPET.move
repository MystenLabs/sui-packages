module 0x779ed3602b7421e29bbc073fdbabf9180783dfa9d2b953698aa587f2da28b3cd::SUIPET {
    struct SUIPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPET>(arg0, 9, b"SUIPET", b"SUIPET", b"SUIPET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746758400594321408/bHUmmi04_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPET>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

