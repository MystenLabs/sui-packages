module 0x1f81828b697be00232d3bbb6f57b694035c083cdcca3e3681321ff74908311dc::hgh {
    struct HGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGH>(arg0, 9, b"HGH", b"ASA", b"Good morning I am not sure if you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9021c3e4-be54-4d5c-b4ed-5bede82ed845.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

