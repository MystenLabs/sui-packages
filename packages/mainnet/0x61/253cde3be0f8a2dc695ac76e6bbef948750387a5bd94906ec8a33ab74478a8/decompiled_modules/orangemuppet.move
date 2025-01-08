module 0x61253cde3be0f8a2dc695ac76e6bbef948750387a5bd94906ec8a33ab74478a8::orangemuppet {
    struct ORANGEMUPPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGEMUPPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGEMUPPET>(arg0, 9, b"ORM", b"ORANGEMUPPET", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-imperial-chimpanzee-578.mypinata.cloud/ipfs/bafkreifbrqlemv6kib52viawnhmv3gjcjdbjnxhdmv7ugxpzedu27qtcbe")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORANGEMUPPET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGEMUPPET>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ORANGEMUPPET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ORANGEMUPPET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

