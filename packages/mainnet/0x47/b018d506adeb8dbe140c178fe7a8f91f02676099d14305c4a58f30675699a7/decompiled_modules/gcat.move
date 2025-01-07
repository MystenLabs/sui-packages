module 0x47b018d506adeb8dbe140c178fe7a8f91f02676099d14305c4a58f30675699a7::gcat {
    struct GCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCAT>(arg0, 6, b"GCAT", b"Ginger cat", b"Hang on kitten, it's either gonna be a blast or possibly kill you but you are not alone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_12_222233_b0bb9be9de.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

