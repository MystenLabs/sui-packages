module 0x44b55e650fd56b09bee5a3d4f8204adcd82421db89d55864c63774d9b5bb5b38::ronald {
    struct RONALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONALD>(arg0, 6, b"RONALD", b"Firelord Ronald", b"Meet Ronald, the Landlord Extraordinaire turned $FIRELORD! When hes not fixing leaky faucets, hes battling blazes. With a vast rental empire, Ronald preps for anything, even fires. Every tenant gets a free fire extinguisher and a \"Stop, Drop, and Roll\" lesson. Rent with Ronaldbecause your safety is his fiery new passion!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/firelord_logo_2acee758c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

