module 0xe4c950e34a952800e3df0657f4ecbc79f9d70db91d4463bb17b92b44d7661eee::leos {
    struct LEOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEOS>(arg0, 6, b"LEOS", b"LEOPOLDSUI", b"$LEOS is happy to have you as an integral part of our suinetwork world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20_ef23461b8c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

