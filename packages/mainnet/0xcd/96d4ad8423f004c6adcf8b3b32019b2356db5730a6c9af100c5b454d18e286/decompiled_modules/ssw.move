module 0xcd96d4ad8423f004c6adcf8b3b32019b2356db5730a6c9af100c5b454d18e286::ssw {
    struct SSW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSW>(arg0, 6, b"SSW", b"SUMO SUI WITCH", b"The first SUMO SUI WITCH  on market. She crush the whale's.  When she is hungry she eat 2 whale's.  Your future girlfriend Sui the witch. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024938_4bc4c03262.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSW>>(v1);
    }

    // decompiled from Move bytecode v6
}

