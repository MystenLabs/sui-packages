module 0xe2eb0920607078ebd50b899724fc36922fd3d0fb8097b0f3451fc015c032bf92::bopcat {
    struct BOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOPCAT>(arg0, 6, b"BOPCAT", b"Bopcat Coin", b"The memecoin you didn't know you needed On Sui! https://bopcatonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_1_920f012839.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

