module 0x744f4dfe16196b367ff8a0a5ad88e74b3db7fa599968bff76324fed49bae8ca7::supercat {
    struct SUPERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERCAT>(arg0, 6, b"SUPERCAT", b"SUPER CAT", b"The strongest cat alive has come to SUI. It's time to save the space from the scummy cabals and jeety guys.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_00_57_02_0c7877641d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

