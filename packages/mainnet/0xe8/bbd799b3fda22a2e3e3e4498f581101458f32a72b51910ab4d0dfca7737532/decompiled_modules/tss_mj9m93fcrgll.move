module 0xe8bbd799b3fda22a2e3e3e4498f581101458f32a72b51910ab4d0dfca7737532::tss_mj9m93fcrgll {
    struct TSS_MJ9M93FCRGLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSS_MJ9M93FCRGLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSS_MJ9M93FCRGLL>(arg0, 9, b"TSS", b"TESTO BONDING", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmVCFK4wzSRXsLKWQJ1nAa3RcM7E1tagpDWdqKukGuMPBM")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSS_MJ9M93FCRGLL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSS_MJ9M93FCRGLL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

