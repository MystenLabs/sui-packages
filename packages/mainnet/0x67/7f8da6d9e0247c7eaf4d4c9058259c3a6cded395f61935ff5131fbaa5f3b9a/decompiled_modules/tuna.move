module 0x677f8da6d9e0247c7eaf4d4c9058259c3a6cded395f61935ff5131fbaa5f3b9a::tuna {
    struct TUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNA>(arg0, 6, b"TUNA", b"Tuna The Dog", x"54756e612054686520446f67202d2054686520646f67207769746820616e206f766572626974652074686174207475726e656420696e746f206120736f6369616c206d656469612073746172200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049422_cac2f78c30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

