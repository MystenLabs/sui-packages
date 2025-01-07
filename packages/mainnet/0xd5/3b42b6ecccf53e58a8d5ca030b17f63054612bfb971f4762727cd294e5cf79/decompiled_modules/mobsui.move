module 0xd53b42b6ecccf53e58a8d5ca030b17f63054612bfb971f4762727cd294e5cf79::mobsui {
    struct MOBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBSUI>(arg0, 6, b"MOBSUI", b"MobSui", b"The Greatest Whale of all time is coming to the Ocean of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mobycapa_57f3497257.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

