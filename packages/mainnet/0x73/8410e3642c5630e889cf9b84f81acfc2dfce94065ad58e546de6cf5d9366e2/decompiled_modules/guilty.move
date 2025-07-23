module 0x738410e3642c5630e889cf9b84f81acfc2dfce94065ad58e546de6cf5d9366e2::guilty {
    struct GUILTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUILTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUILTY>(arg0, 6, b"GUILTY", b"Guiltycat", b"On-chain. Off-guard. GUILTY runs wild on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiav7rcrsyw27xbjs36nrug4yzpymt27ofy2enhhskxxisg2yhhtxa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUILTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUILTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

