module 0x15c07c427107ed148d09aa274623d626f6b7cd029f4d7a7783963f48fe6d3217::SUIDRA {
    struct SUIDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDRA>(arg0, 9, b"sDrago", b"sDrago", b"The biggest memecoin on SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746754525170675712/Q2vQTnk__400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDRA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIDRA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

