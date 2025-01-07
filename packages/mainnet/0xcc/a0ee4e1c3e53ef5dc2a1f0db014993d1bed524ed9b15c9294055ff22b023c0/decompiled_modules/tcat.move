module 0xcca0ee4e1c3e53ef5dc2a1f0db014993d1bed524ed9b15c9294055ff22b023c0::tcat {
    struct TCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCAT>(arg0, 6, b"TCAT", b"TantaiCat", b"Meet Tantai, the adorable kitty who will win your heart! With a charming red hat with sparkling stars, he is the perfect combination of cuteness and style. This feline is not just a pet, but a true fashion icon who brings joy and fun to any space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TCAT_T_Sf9i_B_66_Lu_Gwr_Bs_M5_B_86e34afcf6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

