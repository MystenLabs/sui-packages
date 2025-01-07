module 0x7c5b039a6a55849f75d6de75519c7da633c921b634b918198c2b209edda6ea65::mavro {
    struct MAVRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAVRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAVRO>(arg0, 6, b"MAVRO", b"Mavro On Sui", b"The banking system is immoral and unfair, and cryptocurrency is designed to destroy and change it. The financial apocalypse is inevitable! That's what Mavrodi bequeathed. We are here to make money out of thin air.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018804_177bea00be.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAVRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAVRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

