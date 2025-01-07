module 0x8aa47e3cfbbdf7c40c103f02b928bee233fa5137b7eb507ab67d766efd4e45f1::dicky {
    struct DICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICKY>(arg0, 6, b"DICKY", b"Dicky Duck", x"244469636b7920746865206d6f737420626164617373206475636b206f6e20537569210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_at_12_08_25a_AM_b1b6cdaafe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

