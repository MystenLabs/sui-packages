module 0xccb303b93a89a04e3294c315c9ea3459dda6d01ec4d5ad096843e3fe1a4afb45::fdp {
    struct FDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDP>(arg0, 6, b"FDP", b"JE SUIS UN FILS DE PUTE", b"J'aime les gros zeub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_02_27_09_42_47_2_a1a2659830.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

