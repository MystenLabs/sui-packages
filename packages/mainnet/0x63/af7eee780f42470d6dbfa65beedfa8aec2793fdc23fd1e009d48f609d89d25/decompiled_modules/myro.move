module 0x63af7eee780f42470d6dbfa65beedfa8aec2793fdc23fd1e009d48f609d89d25::myro {
    struct MYRO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYRO>, arg1: 0x2::coin::Coin<MYRO>) {
        0x2::coin::burn<MYRO>(arg0, arg1);
    }

    fun init(arg0: MYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYRO>(arg0, 9, b"MYRO", b"MYRO on Sui", b"https://twitter.com/MyroSui https://t.me/myroSUI https://www.myrothedoge.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dli4c64vxmhocabj7z4vzfxk4bl3k5dy4xsutljep5owx3plubcq.arweave.net/GtHBe5W7DuEAKf55XJbq4Fe1dHjl5UmtJH9da-3roEU"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYRO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYRO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

