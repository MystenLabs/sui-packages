module 0x182c235640856b2241b8ec362c1d1c78701834cb58cd569bf8bf810957e0a9d4::aaa111 {
    struct AAA111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA111>(arg0, 9, b"AAA111", b"Ghost", b"Super pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb576a36-e4aa-4f06-ac37-d052b07cf22b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA111>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA111>>(v1);
    }

    // decompiled from Move bytecode v6
}

