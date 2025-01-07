module 0x159c82aee9f8b8b443197c56743e1b07b815ca60a6fc51f399d885b18083ee10::suibear {
    struct SUIBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEAR>(arg0, 6, b"SUIBEAR", b"Sui Bear", b"Sui Bears here with claws out and zero chill. Half hibernation, half domination. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_62e9d444ca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

