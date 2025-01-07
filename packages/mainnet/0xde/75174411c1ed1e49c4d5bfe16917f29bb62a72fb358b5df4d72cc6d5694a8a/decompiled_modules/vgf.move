module 0xde75174411c1ed1e49c4d5bfe16917f29bb62a72fb358b5df4d72cc6d5694a8a::vgf {
    struct VGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: VGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VGF>(arg0, 9, b"VGF", b"Bb", b"Mbv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/440379db-2c96-40ec-b4cd-2222d689317d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

