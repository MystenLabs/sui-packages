module 0xf14750c4de7c1c4a4386628873a02d8c2446637a95bda484c072652d9c9b6ec2::umi {
    struct UMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UMI>(arg0, 9, b"UMI", b"Umicoin", b"Umi means sea. Unicoin is built on the sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/069d26df-f414-47a8-8282-140256ae75ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

