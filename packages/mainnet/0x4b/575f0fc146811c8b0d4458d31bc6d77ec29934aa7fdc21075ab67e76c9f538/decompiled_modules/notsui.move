module 0x4b575f0fc146811c8b0d4458d31bc6d77ec29934aa7fdc21075ab67e76c9f538::notsui {
    struct NOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTSUI>(arg0, 9, b"NOTSUI", b"NOTSUI COI", x"4a6f696e2074686520706c617966756c20726562656c6c696f6e207769746820244e4f545355492c20746865206d656d65746f6b656e20746861742063656c656272617465732068756d6f722c207361746972652c20616e6420636f6d6d756e6974792e20486564676520616761696e737420736572696f75736e65737320616e6420696e7665737420696e20746865206c617567687465722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37a28309-c9cc-49da-8949-65dd9250938f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

