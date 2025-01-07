module 0xb4b1fd8b84920ce4101522b79f876cf4083ed0bf9f0c0adde5e67cdc2233aefe::chillsquid {
    struct CHILLSQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSQUID>(arg0, 6, b"ChillSquid", b"Chill Squid On Sui", b"Welcome to a whole new world where the intensity of Squid Game is gone, replaced by pure relaxation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/itk_Rl_Te_400x400_ee70f051f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLSQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

