module 0x3ed5d573eefc4d03ed76cbdcbbcce2738a3864c9d81ea4ba32f778b3186feb91::asteroid {
    struct ASTEROID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTEROID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTEROID>(arg0, 6, b"ASTEROID", b"Asteroid On Sui", x"41737465726f6964204f6e205375690a696e73706972656420627920746865207a65726f2d6772617669747920536869626120496e7520746f79206e616d6564202241737465726f6964222074686174206163636f6d70616e6965642074686520506f6c61726973204461776e206d697373696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Asteroid_b4440f540a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTEROID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTEROID>>(v1);
    }

    // decompiled from Move bytecode v6
}

