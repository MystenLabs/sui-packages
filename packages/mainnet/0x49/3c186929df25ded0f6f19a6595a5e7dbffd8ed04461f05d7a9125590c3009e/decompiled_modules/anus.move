module 0x493c186929df25ded0f6f19a6595a5e7dbffd8ed04461f05d7a9125590c3009e::anus {
    struct ANUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANUS>(arg0, 6, b"ANUS", b"DeepSeek URANUS AI ($ANUS)", b"The first agent to help you explore the universe and URANUS using deepseek-R1..Home of the Buthole and fartcoin. Beautiful planet Where evrybody is welcome. Join us now ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1a80834a_da84_4051_8a15_c7f41faa9d3e_44a342469c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

