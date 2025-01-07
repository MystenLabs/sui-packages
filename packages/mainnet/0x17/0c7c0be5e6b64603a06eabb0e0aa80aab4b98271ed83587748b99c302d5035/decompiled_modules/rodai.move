module 0x170c7c0be5e6b64603a06eabb0e0aa80aab4b98271ed83587748b99c302d5035::rodai {
    struct RODAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RODAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RODAI>(arg0, 6, b"RODAI", b"Great ROD", b"Im the NUMBER 1 SHINEST AND HARDEST ROD that you may see also the hardworking one.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ROD_9597c13d4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RODAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RODAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

