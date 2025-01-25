module 0xcc4ef21677bac81d95042728ae9a844fdae60a0d4a09fb943847c41112a79ad6::dls {
    struct DLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLS>(arg0, 9, b"DLS", b"DeepLinkSui", b"Decentralized AI Cloud Gaming Protocol=AI + DePIN + AI Agent+ Cloud Game + GPU. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/3a2bbf50-daeb-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLS>>(v1);
        0x2::coin::mint_and_transfer<DLS>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

