module 0x61b0c8d1846605aa51cc2f02323b31b72041722c10e661fe0bbf334aa7d78ef5::rhinoai {
    struct RHINOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHINOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHINOAI>(arg0, 6, b"RhinoAI", b"Rhino AI", x"4665656c696e672062756c6c6973683f204c6574e2809973207374616d70656465207468652063727970746f206d61726b657420746f67657468657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736040879761.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHINOAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHINOAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

