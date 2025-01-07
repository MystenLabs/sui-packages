module 0x2da200570236e688ae4bfc23eb6b1cef09957dc4c7d4e29a3f3e3b2beeffc421::dogskaka {
    struct DOGSKAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSKAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSKAKA>(arg0, 9, b"DOGSKAKA", b"Wawe", b"You why to me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c10785a7-c84a-4fbc-afd5-59c91bce3567.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSKAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSKAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

