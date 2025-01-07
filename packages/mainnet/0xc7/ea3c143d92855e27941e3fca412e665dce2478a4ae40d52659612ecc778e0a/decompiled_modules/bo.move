module 0xc7ea3c143d92855e27941e3fca412e665dce2478a4ae40d52659612ecc778e0a::bo {
    struct BO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BO>(arg0, 6, b"BO", b"blue octopus", b"I'm a cute octopus and I want to ride the wave. Help me grow up and we'll catch whales.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/caracatita_pe_val_6403e75b8c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BO>>(v1);
    }

    // decompiled from Move bytecode v6
}

