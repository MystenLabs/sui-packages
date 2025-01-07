module 0x5043e7b3715f1d3141e254dc9976b7b34f5ff2e5125c664459e43f4bd243eb17::suisui {
    struct SUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUI>(arg0, 6, b"Suisui", b"SUI SUI", b"SuiSui Token | Play-to-Earn bird racing on Sui blockchain. Compete, earn tokens & shape the future with our DAO. Join the flight! #S", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2347_8e3f84d3da.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

