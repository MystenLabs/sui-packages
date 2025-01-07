module 0x546f938ee5cb7f9d36fd1decb1745770c5c20413ada9b7394cecc9df381c18c5::suinald {
    struct SUINALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINALD>(arg0, 6, b"SUINALD", b"DONALD on SUI", b" SUINALD is Making SUI Great Again!  By the people, for the people! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k9tnjbxo_400x400_1_282b14a06e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

