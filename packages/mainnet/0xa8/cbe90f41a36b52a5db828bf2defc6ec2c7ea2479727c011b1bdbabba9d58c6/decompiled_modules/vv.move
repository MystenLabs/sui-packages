module 0xa8cbe90f41a36b52a5db828bf2defc6ec2c7ea2479727c011b1bdbabba9d58c6::vv {
    struct VV has drop {
        dummy_field: bool,
    }

    fun init(arg0: VV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VV>(arg0, 9, b"VV", b"Cc", b"Ch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6c5fdf9-6087-4eab-ae5b-a1c08a639ad4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VV>>(v1);
    }

    // decompiled from Move bytecode v6
}

