module 0x91a73a6bc4722363a4541d3e0704b0df8702006bc53cdde6e1b66f811d26e493::story {
    struct STORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STORY>(arg0, 6, b"Story", b"IP", b"Story is creating the world's IP Blockchain, an L1 that allows anyone to put intellectual property (IP) on-chain, turning them into programmable IP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/89d4db7b-aa43-4401-addf-4a65763b2737.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STORY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STORY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

