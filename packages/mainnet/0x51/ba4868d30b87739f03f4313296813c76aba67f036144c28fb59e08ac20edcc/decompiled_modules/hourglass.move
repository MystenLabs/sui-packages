module 0x51ba4868d30b87739f03f4313296813c76aba67f036144c28fb59e08ac20edcc::hourglass {
    struct HOURGLASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOURGLASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOURGLASS>(arg0, 6, b"Hourglass", b"Time Hourglass", b"Your time is secretly flowing away, please seize it,this hourglass will tell you what time represents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GW_8ob_HTW_8_A_En171_4c69a72cc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOURGLASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOURGLASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

