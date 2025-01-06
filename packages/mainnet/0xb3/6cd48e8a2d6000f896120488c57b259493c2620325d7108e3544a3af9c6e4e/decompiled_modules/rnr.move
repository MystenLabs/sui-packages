module 0xb36cd48e8a2d6000f896120488c57b259493c2620325d7108e3544a3af9c6e4e::rnr {
    struct RNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RNR>(arg0, 9, b"RNR", b"Rock'n'Rol", x"4d7573696320f09f8eb520546f6b656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87ebab88-e504-447a-a917-6f7c75d74906.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RNR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RNR>>(v1);
    }

    // decompiled from Move bytecode v6
}

