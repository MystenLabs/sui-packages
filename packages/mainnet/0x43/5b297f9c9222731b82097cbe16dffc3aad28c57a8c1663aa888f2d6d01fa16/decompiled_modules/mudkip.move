module 0x435b297f9c9222731b82097cbe16dffc3aad28c57a8c1663aa888f2d6d01fa16::mudkip {
    struct MUDKIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDKIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDKIP>(arg0, 6, b"Mudkip", b"MudkipOnSui", x"4d75646b697020697320612066756e2c20636f6d6d756e6974792d64726976656e206d656d6520636f696e206f6e207468652053756920626c6f636b636861696e2e0a4a6f696e20746865204d75646b697020436f6d6d756e69747920616e642062652070617274206f66207468652066756e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730730526419.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDKIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDKIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

