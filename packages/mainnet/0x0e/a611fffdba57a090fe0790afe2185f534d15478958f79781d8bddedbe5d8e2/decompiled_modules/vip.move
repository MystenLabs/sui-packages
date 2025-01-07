module 0xea611fffdba57a090fe0790afe2185f534d15478958f79781d8bddedbe5d8e2::vip {
    struct VIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIP>(arg0, 9, b"VIP", b"T1", b"T1 Number One", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b9046cb-ebb4-4a1b-88cc-432816fb3075.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

