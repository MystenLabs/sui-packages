module 0xc46c08719ccfca53304704eb922297d2bdd321d8d8efb3a71f4fd8df0c3dd8b5::miumiu {
    struct MIUMIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIUMIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIUMIU>(arg0, 9, b"MIUMIU", b"Miu Coin", b"MIU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/18a2eb3534257c514667b45e4d8325a5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIUMIU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIUMIU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

