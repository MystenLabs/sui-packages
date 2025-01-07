module 0x3f169942858eacecf8b87168ce3f1b87551820b11dcca5416b81b04b128c9f0d::sopcat {
    struct SOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOPCAT>(arg0, 6, b"SOPCAT", b"Sui Popcat", b"SOPCAT, SUI POPCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sopelogo_f0974d4a9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

