module 0x5fd2438aee0809045355f1a1742869a694bb572b99c69f01a6e4579446d8e1dc::trump47 {
    struct TRUMP47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP47>(arg0, 6, b"Trump47", b"Trump47thpresident", b"Donald John Trump is an American politician, media personality, and businessman who served as the 45th president of the United States from 2017 to 2021. Trump received a Bachelor of Science degree in economics from the University of Pennsylvania in 1968", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TRUMP_47_532e66ea25.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP47>>(v1);
    }

    // decompiled from Move bytecode v6
}

