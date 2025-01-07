module 0xcee928e01184317ac968d3e13526d23baa5177980407e3718316b96b5922b311::sssffscoin {
    struct SSSFFSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSFFSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSFFSCOIN>(arg0, 6, b"SSSFFSCoin", b"SSSFFS Coin", b"Secure Borders -Sensible Spending -Safe Cities -Fair Justice System -Free Speech -Self-Protection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U3_E_Zmd_Uz_400x400_b262aa901a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSFFSCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSSFFSCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

