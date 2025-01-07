module 0x710c43ace55d18946c2e45c14ef1aa11a598047198a8ef18d6514d0e7dc0a646::jdfh {
    struct JDFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDFH>(arg0, 9, b"JDFH", b"DFJ", b"DHFH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee90b261-258b-4492-a314-509c7b7be714.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JDFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

