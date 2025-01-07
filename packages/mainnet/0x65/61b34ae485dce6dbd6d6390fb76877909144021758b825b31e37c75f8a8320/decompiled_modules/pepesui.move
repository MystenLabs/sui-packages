module 0x6561b34ae485dce6dbd6d6390fb76877909144021758b825b31e37c75f8a8320::pepesui {
    struct PEPESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESUI>(arg0, 6, b"PEPESUI", b"Pepe on SUI Sui", x"2450455045535549206f6e205355492c20746865206d6f7374206d656d6561626c65206d656d65636f696e206f6e20245355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pepe_on_SUI_Sui_a9b8116a78.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

