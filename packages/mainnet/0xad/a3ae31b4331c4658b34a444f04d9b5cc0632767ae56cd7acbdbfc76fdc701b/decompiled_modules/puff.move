module 0xada3ae31b4331c4658b34a444f04d9b5cc0632767ae56cd7acbdbfc76fdc701b::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"PUFFER", x"4c6567656e64617279205075666665722050756666696e67206f6e200a405375694e6574776f726b0a0a0a5055464620686572653a2068747470733a2f2f742e6d652f5075666665725355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Df_EC_Chq_T_400x400_b8a050b9e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

