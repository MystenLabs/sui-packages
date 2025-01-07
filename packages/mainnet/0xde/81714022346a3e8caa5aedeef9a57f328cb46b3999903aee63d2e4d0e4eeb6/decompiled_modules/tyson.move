module 0xde81714022346a3e8caa5aedeef9a57f328cb46b3999903aee63d2e4d0e4eeb6::tyson {
    struct TYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYSON>(arg0, 6, b"TYSON", b"Sui Tyson", b"Meet Sui $TYSON, The gloves are on, and Team Tyson is ready to roll on Sui! Join Team Tyson, rep the power, and show your support where it count, in the ring and on the Sui Chain. Lets make history, $TYSON style!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Tyson_3537131dc8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

