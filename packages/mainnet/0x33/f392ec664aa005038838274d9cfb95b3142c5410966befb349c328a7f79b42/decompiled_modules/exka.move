module 0x33f392ec664aa005038838274d9cfb95b3142c5410966befb349c328a7f79b42::exka {
    struct EXKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXKA, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 809 || 0x2::tx_context::epoch(arg1) == 810, 1);
        let (v0, v1) = 0x2::coin::create_currency<EXKA>(arg0, 6, b"exka", b"exka", b"Exka is a real-world asset (RWA) token project aiming to buy construction machines like excavators with token revenue and share the income with holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmZJF51uxV9zYujJue67ymQJ1hg4unqSY1bgxqGaRr6PLc"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EXKA>(&mut v2, 50000000000000, @0xe4fa4ff3b902d184f653431599fe1965c2189c729a8a8dfcea110c6fafc41f20, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXKA>>(v2, @0xe4fa4ff3b902d184f653431599fe1965c2189c729a8a8dfcea110c6fafc41f20);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

