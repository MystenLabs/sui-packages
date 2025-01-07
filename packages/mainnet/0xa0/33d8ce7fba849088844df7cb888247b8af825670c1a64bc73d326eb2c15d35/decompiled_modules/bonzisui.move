module 0xa033d8ce7fba849088844df7cb888247b8af825670c1a64bc73d326eb2c15d35::bonzisui {
    struct BONZISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONZISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONZISUI>(arg0, 6, b"BonziSui", b"BonSui", b"BonziBuddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bonzi_sui_87c072790f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONZISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONZISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

