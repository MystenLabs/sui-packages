module 0x19739b2e122ef4276afcc40dfccf355c3b63b93ab66d9dfda21e526c8f76bc56::pcat {
    struct PCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCAT>(arg0, 9, b"PCAT", b"Persian cat", b"PCAT On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQjr-6m4fJFTmH4sIqOHIMJbQBTMw4JhG-CcVscjg5N-fDXF6ku"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCAT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PCAT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

