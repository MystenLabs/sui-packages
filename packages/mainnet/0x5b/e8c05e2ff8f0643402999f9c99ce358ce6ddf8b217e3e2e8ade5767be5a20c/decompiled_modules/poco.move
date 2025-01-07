module 0x5be8c05e2ff8f0643402999f9c99ce358ce6ddf8b217e3e2e8ade5767be5a20c::poco {
    struct POCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCO>(arg0, 6, b"POCO", b"POCO by Matt Furie", x"506f636f205375692c20746865207765616c74686965737420666f7820696e2063727970746f2e20496e737069726564206279204d617474204675726965206c6567656e64617279206368617261637465722120536f6c6964206d61726b6574696e6720746f20636f6d6520706f7374206c61756e636820696e636c7564696e67207472656e64696e67732c206c697374696e677320616e642061676772657373697665206d61726b6574696e67206f6e20616c6c20706c6174666f726d73200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_11_13_13_26_2a87a0ae9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

