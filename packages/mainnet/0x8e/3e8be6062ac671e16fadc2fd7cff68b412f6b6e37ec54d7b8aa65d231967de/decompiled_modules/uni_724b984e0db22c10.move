module 0x8e3e8be6062ac671e16fadc2fd7cff68b412f6b6e37ec54d7b8aa65d231967de::uni_724b984e0db22c10 {
    struct UNI_724B984E0DB22C10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI_724B984E0DB22C10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI_724B984E0DB22C10>(arg0, 0, b"UNI", b"Uni", b"Pump-style launch token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suigift.fun/api/uploads/token-icons/1788191788099-61ed540c-85db-49a8-a9c8-2a63baf2db42.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNI_724B984E0DB22C10>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UNI_724B984E0DB22C10>>(0x2::coin::mint<UNI_724B984E0DB22C10>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI_724B984E0DB22C10>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

