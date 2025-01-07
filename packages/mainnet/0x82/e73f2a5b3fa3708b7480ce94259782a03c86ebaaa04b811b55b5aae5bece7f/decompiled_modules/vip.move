module 0x82e73f2a5b3fa3708b7480ce94259782a03c86ebaaa04b811b55b5aae5bece7f::vip {
    struct VIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIP>(arg0, 9, b"VIP", b"VIPCOIN", b"VIP coin for VIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c018a9e5-cd55-4567-bfaa-9746e1756d22.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

