module 0x59e5f37dae3a05bcb4e7d64b6cd876febbf4c61f5083d6a34dd1b7b0c529cbf::vnc {
    struct VNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNC>(arg0, 9, b"VNC", b"VietNamC", x"c490e1bb936e6720436f696e2043e1bba761205669e1bb8774204e616d20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9c845a2-412a-46e4-b9a4-ada960d5aa53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

