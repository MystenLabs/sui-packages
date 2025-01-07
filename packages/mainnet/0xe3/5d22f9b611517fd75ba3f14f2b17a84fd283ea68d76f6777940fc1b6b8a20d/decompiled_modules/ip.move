module 0xe35d22f9b611517fd75ba3f14f2b17a84fd283ea68d76f6777940fc1b6b8a20d::ip {
    struct IP has drop {
        dummy_field: bool,
    }

    fun init(arg0: IP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IP>(arg0, 9, b"IP", b"iphone", b"iphone home", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8278f9d9-414a-487f-b724-0d01fbdd68ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IP>>(v1);
    }

    // decompiled from Move bytecode v6
}

