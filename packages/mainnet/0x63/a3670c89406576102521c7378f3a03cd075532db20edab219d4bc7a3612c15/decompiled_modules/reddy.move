module 0x63a3670c89406576102521c7378f3a03cd075532db20edab219d4bc7a3612c15::reddy {
    struct REDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDDY>(arg0, 6, b"REDDY", b"Reddy Fish Sui", b"$REDY is a cute little red fish token on the sui blockchain, full of color and magic on the sui network, Small in size but big in personality, this cute fish is ready to go on an adventure with you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001850_0d1c753622.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

