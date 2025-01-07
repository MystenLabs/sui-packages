module 0xd25afae950e5dd08d2c80dc2da358a580f40dac7cee97c785aae1585fe8a2676::pcb {
    struct PCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCB>(arg0, 8, b"PCB", b"Poseidon Club", b"Poseidon Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/J0hxBqu.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PCB>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

