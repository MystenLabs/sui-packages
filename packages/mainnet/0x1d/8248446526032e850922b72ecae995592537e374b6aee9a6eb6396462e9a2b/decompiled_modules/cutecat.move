module 0x1d8248446526032e850922b72ecae995592537e374b6aee9a6eb6396462e9a2b::cutecat {
    struct CUTECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTECAT>(arg0, 6, b"CUTECAT", b"Sui CuteCat", b"Cute Cat rises to rule the SUI Blockchain with charm and community power", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250502_012648_84b6e15c7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUTECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

