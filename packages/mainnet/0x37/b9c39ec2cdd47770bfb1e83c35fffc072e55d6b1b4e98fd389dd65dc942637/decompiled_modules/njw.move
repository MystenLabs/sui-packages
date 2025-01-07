module 0x37b9c39ec2cdd47770bfb1e83c35fffc072e55d6b1b4e98fd389dd65dc942637::njw {
    struct NJW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJW>(arg0, 9, b"NJW", b"Najwas", b"Family token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e55ec48-213c-40fd-8d46-42691c93edb7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NJW>>(v1);
    }

    // decompiled from Move bytecode v6
}

